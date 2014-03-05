This is a demonstration of what appears to be a bug in `UITableView`. In some circumstances, the `<UITableViewDelegate>`
methods `-tableView:willDisplayHeaderView:forSection:` and `tableView:didEndDisplayingHeaderView:forSection:` are not
called. These circumstances are when a header comes into / disappears from view due to rows being inserted or deleted.
The methods *are* called as expected when the user scrolls through the table view.

This is demonstrated in the attached project. Tapping on the section header will expand/collapse that section. Note
that the delegate methods are not logged. Notice that scrolling through the tableview does cause the method calls to
be logged.

rdar://16242777 filed with Apple.
