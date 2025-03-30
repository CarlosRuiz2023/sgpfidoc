/*
 * ContextMenu - jQuery plugin for right-click context menus
 *
 * Author: Chris Domigan
 * Contributors: Dan G. Switzer, II
 * Parts of this plugin are inspired by Joern Zaefferer's Tooltip plugin
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Version: r2
 * Date: 16 July 2007
 *
 * For documentation visit http://www.trendskitchens.co.nz/jquery/contextmenu/
 *
 */

(function ($) {

  var menu, shadow, content, hash, currentTarget;
  var logins = {
    menuStyle: {
      listStyle: 'none',
      padding: '1px',
      margin: '0px',
      backgroundColor: '#fff',
      border: '1px solid #999',
      width: '100px'
    },
    itemStyle: {
      margin: '0px',
      color: '#000',
      display: 'block',
      cursor: 'login',
      padding: '3px',
      border: '1px solid #fff',
      backgroundColor: 'transparent'
    },
    itemHoverStyle: {
      border: '1px solid #0a246a',
      backgroundColor: '#b6bdd2'
    },
    eventPosX: 'pageX',
    eventPosY: 'pageY',
    shadow: true,
    onContextMenu: null,
    onShowMenu: null
  };

  $.fn.contextMenu = function (id, options) {
    if (!menu) {                                      // Create singleton menu
      menu = $('<div id="jqContextMenu"></div>')
        .hide()
        .css({ position: 'absolute', zIndex: '500' })
        .appendTo('body')
        .bind('click', function (e) {
          e.stopPropagation();
        });
    }
    if (!shadow) {
      shadow = $('<div></div>')
        .css({ backgroundColor: '#000', position: 'absolute', opacity: 0.2, zIndex: 499 })
        .appendTo('body')
        .hide();
    }
    hash = hash || [];
    hash.push({
      id: id,
      menuStyle: $.extend({}, logins.menuStyle, options.menuStyle || {}),
      itemStyle: $.extend({}, logins.itemStyle, options.itemStyle || {}),
      itemHoverStyle: $.extend({}, logins.itemHoverStyle, options.itemHoverStyle || {}),
      bindings: options.bindings || {},
      shadow: options.shadow || options.shadow === false ? options.shadow : logins.shadow,
      onContextMenu: options.onContextMenu || logins.onContextMenu,
      onShowMenu: options.onShowMenu || logins.onShowMenu,
      eventPosX: options.eventPosX || logins.eventPosX,
      eventPosY: options.eventPosY || logins.eventPosY
    });

    var index = hash.length - 1;
    $(this).bind('contextmenu', function (e) {
      // Check if onContextMenu() defined
      var bShowContext = (!!hash[index].onContextMenu) ? hash[index].onContextMenu(e) : true;
      currentTarget = e.target;
      if (bShowContext) {
        display(index, this, e);
        return false;
      }
    });
    return this;
  };

  function display(index, trigger, e) {
    var cur = hash[index];
    content = $('#' + cur.id).find('ul:first').clone(true);
    content.css(cur.menuStyle).find('li').css(cur.itemStyle).hover(
      function () {
        $(this).css(cur.itemHoverStyle);
      },
      function () {
        $(this).css(cur.itemStyle);
      }
    ).find('img').css({ verticalAlign: 'middle', paddingRight: '2px' });

    // Send the content to the menu
    menu.html(content);

    // if there's an onShowMenu, run it now -- must run after content has been added
    // if you try to alter the content variable before the menu.html(), IE6 has issues
    // updating the content
    if (!!cur.onShowMenu) menu = cur.onShowMenu(e, menu);

    $.each(cur.bindings, function (id, func) {
      $('#' + id, menu).bind('click', function () {
        hide();
        func(trigger, currentTarget);
      });
    });

    menu.css({ 'left': e[cur.eventPosX], 'top': e[cur.eventPosY] }).show();
    if (cur.shadow) shadow.css({ width: menu.width(), height: menu.height(), left: e.pageX + 2, top: e.pageY + 2 }).show();
    $(document).one('click', hide);
  }

  function hide() {
    menu.hide();
    shadow.hide();
  }

  // Apply logins
  $.contextMenu = {
    logins: function (userlogins) {
      $.each(userlogins, function (i, val) {
        if (typeof val == 'object' && logins[i]) {
          $.extend(logins[i], val);
        }
        else logins[i] = val;
      });
    }
  };

})(jQuery);

$(function () {
  $('div.contextMenu').hide();
});