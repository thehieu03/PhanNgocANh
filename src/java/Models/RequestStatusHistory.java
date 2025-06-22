/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;

/**
 *
 * @author hieun
 */
public class RequestStatusHistory {
    private int historyId;
    private int requestId;
    private int fromStatusId;
    private int toStatusId;
    private int changedBy;
    private LocalDateTime changedAt;
    private String comment;

    public RequestStatusHistory() {
    }

    public RequestStatusHistory(int historyId, int requestId, int fromStatusId, int toStatusId, int changedBy, LocalDateTime changedAt, String comment) {
        this.historyId = historyId;
        this.requestId = requestId;
        this.fromStatusId = fromStatusId;
        this.toStatusId = toStatusId;
        this.changedBy = changedBy;
        this.changedAt = changedAt;
        this.comment = comment;
    }

    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getFromStatusId() {
        return fromStatusId;
    }

    public void setFromStatusId(int fromStatusId) {
        this.fromStatusId = fromStatusId;
    }

    public int getToStatusId() {
        return toStatusId;
    }

    public void setToStatusId(int toStatusId) {
        this.toStatusId = toStatusId;
    }

    public int getChangedBy() {
        return changedBy;
    }

    public void setChangedBy(int changedBy) {
        this.changedBy = changedBy;
    }

    public LocalDateTime getChangedAt() {
        return changedAt;
    }

    public void setChangedAt(LocalDateTime changedAt) {
        this.changedAt = changedAt;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
}
