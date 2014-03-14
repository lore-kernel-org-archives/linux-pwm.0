From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/2] PWM: atmel: few fixes
Date: Fri, 14 Mar 2014 15:19:07 +0100
Message-ID: <1394806749-29778-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48109 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755081AbaCNOTQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Mar 2014 10:19:16 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

Here are a few improvement for pwm-atmel. The first patch makes the driver
actually respect the polarity.

The second patch is solving an issue that I was trying to solve back in october.
When the channel was disabled, the output level got inversed. It actually was
that we had the polarity wrong from the beginning.

Alexandre Belloni (2):
  PWM: atmel-pwm: Fix polarity handling
  PWM: atmel: correct CDTY calculation

 drivers/pwm/pwm-atmel.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.3.2

