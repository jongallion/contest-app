class @ContestCookie
  constructor: ->
   @setContestCookie()

  setContestCookie: ->
    value = new Date()
    expirationDate = new Date()
    expirationDate.setHours(24,0,0,0)
    $.cookie('contest_viewed', value, { expires: expirationDate, path: '/' });

@CONTEST = {}

$ ->
  CONTEST.ContestCookie = new ContestCookie() if $('.modal').length
