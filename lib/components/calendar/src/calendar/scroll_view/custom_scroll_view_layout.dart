part of calendar;

class _CustomScrollViewerLayout extends MultiChildRenderObjectWidget {
  _CustomScrollViewerLayout(List<Widget> children, this._calendar,
      this._position, this._currentChildIndex)
      : super(children: children);
  final SfCalendar _calendar;
  final double _position;
  final int _currentChildIndex;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CustomScrollViewLayout(_calendar, _position, _currentChildIndex);
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    final _CustomScrollViewLayout panel = context.findRenderObject();
    if (panel._calendar.monthViewSettings.navigationDirection !=
            _calendar.monthViewSettings.navigationDirection ||
        panel._calendar.view != _calendar.view) {
      panel._calendar = _calendar;
    }

    if (panel._position != null && _position == null) {
      panel._position = null;
      panel.markNeedsLayout();
    }

    if (panel._currentChildIndex != _currentChildIndex) {
      panel._currentChildIndex = _currentChildIndex;
      panel.markNeedsLayout();
    }

    if (panel._position != _position) {
      panel._position = _position;
      panel.markNeedsLayout();
    }
  }
}

class _CustomScrollViewLayout extends RenderWrap {
  _CustomScrollViewLayout(
      this._calendar, this._position, this._currentChildIndex);

  SfCalendar _calendar;

  // holds the index of the current displaying view
  int _currentChildIndex;

  // _position contains distance that the view swiped
  double _position;

  // used to position the children on the panel on swiping.
  dynamic _currentChild, _firstChild, _lastChild;

  @override
  void performLayout() {
    double currentChildXPos,
        firstChildXPos = 0,
        lastChildXPos,
        currentChildYPos,
        firstChildYPos = 0,
        lastChildYPos;
    WrapParentData currentChildParentData,
        firstChildParentData,
        lastChildParentData;

    double width = constraints.maxWidth;
    double height = constraints.maxHeight;

    final dynamic children = getChildrenAsList();
    _firstChild = _firstChild ?? firstChild;
    _lastChild = _lastChild ?? lastChild;
    _currentChild = _currentChild ?? childAfter(firstChild);

    if (_calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.horizontal ||
        _calendar.view != CalendarView.month) {
      width = width / 3;
      firstChildXPos = 0;
      currentChildYPos = 0;
      lastChildYPos = 0;
    } else if (_calendar.view == CalendarView.month &&
        _calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.vertical) {
      height = height / 3;
      firstChildYPos = 0;
      currentChildXPos = 0;
      lastChildXPos = 0;
    }

    //// sets the position as zero to restrict the view update when the view refreshed without swiping the view
    if (_position == width || _position == -width) {
      if (_currentChild.parentData.offset.dx == width) {
        _position = 0;
      }
    } else if (_position == height || _position == -height) {
      if (_currentChild.parentData.offset.dy == height) {
        _position = 0;
      }
    }

    firstChildParentData = _firstChild.parentData;
    lastChildParentData = _lastChild.parentData;
    currentChildParentData = _currentChild.parentData;
    if (_calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.horizontal ||
        _calendar.view != CalendarView.month) {
      currentChildXPos = width;
      lastChildXPos = width * 2;
      if (_position != null) {
        firstChildXPos += _position;
        currentChildXPos += _position;
        lastChildXPos += _position;

        if (firstChildXPos.round() == -width.round()) {
          firstChildXPos = width * 2;
          _updateChild();
        } else if (lastChildXPos.round() == (width * 3).round()) {
          lastChildXPos = 0;
          _updateChild();
        }
      }
    } else if (_calendar.view == CalendarView.month &&
        _calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.vertical) {
      currentChildYPos = height;
      lastChildYPos = height * 2;
      if (_position != null) {
        firstChildYPos += _position;
        currentChildYPos += _position;
        lastChildYPos += _position;

        if (firstChildYPos.round() == -height.round()) {
          firstChildYPos = height * 2;
          _updateChild();
        } else if (lastChildYPos.round() == (height * 3).round()) {
          lastChildYPos = 0;
          _updateChild();
        }
      }
    }

    firstChildParentData.offset = Offset(firstChildXPos, firstChildYPos);
    currentChildParentData.offset = Offset(currentChildXPos, currentChildYPos);
    lastChildParentData.offset = Offset(lastChildXPos, lastChildYPos);

    children.forEach((dynamic child) => child.layout(
        BoxConstraints(
          minWidth: 0,
          minHeight: 0,
          maxWidth: width,
          maxHeight: height,
        ),
        parentUsesSize: true));

    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  //// method to update the child position based on the current child index
  void _updateChild() {
    final dynamic children = getChildrenAsList();
    if (_currentChildIndex == 0) {
      _currentChild = children[_currentChildIndex];
      _firstChild = children[2];
      _lastChild = children[1];
    } else if (_currentChildIndex == 1) {
      _currentChild = children[_currentChildIndex];
      _firstChild = children[0];
      _lastChild = children[2];
    } else if (_currentChildIndex == 2) {
      _currentChild = children[_currentChildIndex];
      _firstChild = children[1];
      _lastChild = children[0];
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
  }
}
