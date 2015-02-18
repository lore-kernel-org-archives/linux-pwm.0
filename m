From: Gaetan Hug <ghug@induct.be>
Subject: [PATCH 0/1] fix for pwm-mxs period divider computation
Date: Wed, 18 Feb 2015 09:18:55 +0100
Message-ID: <1424247536-16476-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-am1on0143.outbound.protection.outlook.com ([157.56.112.143]:16524
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751054AbbBRITI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 18 Feb 2015 03:19:08 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gaetan Hug <ghug@induct.be>

Hello Thierry,

   I found a bug in the pwm-mxs.c driver for the i.MX28 platform.

   The driver computes from the desired period which clock divider it
should be using. This computation assumes that the link between the
register value and the actual divider value is raising 2 to the power of
the registry value.

    div = 1 << regvalue

   This is true only for the first 5 values out of 8. Next values are
64, 256 and, 1024.
   This affects only the user only if he requests a period > 0.04369s.

Gaetan Hug (1):
  fixing pwm-mxs period divider computation

 drivers/pwm/pwm-mxs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--
1.7.10.4

