interface GridListener {
    void onRowAppendedOrMoved(int existingIdx, int newIdx);
}

class Grid {
    GridListener listeners[];
    void onRowAppendedOrMoved(int existingIdx=default, int newIdx=default) {
        //append a row at the end of the grid.
        for (int i = 0; i < listeners.length; i++) {
            listeners[i].onRowAppended(existingIdx,newIdx);
        }
    }




update-alternatives --remove java /opt/jdk/jdk1.6.0_65/bin/java