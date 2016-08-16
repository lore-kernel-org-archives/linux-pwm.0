From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 0/1] pwm: sun4i: fix a possible NULL dereference
Date: Tue, 16 Aug 2016 15:18:05 +0200
Message-ID: <1471353486-11514-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33313 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbcHPNS0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2016 09:18:26 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: maxime.ripard@free-electrons.com, thierry.reding@gmail.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

Hello

Change since v1:
- Use of_device_get_match_data()

LABBE Corentin (1):
  pwm: sun4i: fix a possible NULL dereference

 drivers/pwm/pwm-sun4i.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.7.3
