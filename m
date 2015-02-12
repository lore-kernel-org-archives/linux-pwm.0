From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting brightness
Date: Thu, 12 Feb 2015 10:44:48 +0100
Message-ID: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58652 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbbBLJpT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Feb 2015 04:45:19 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Hello,

on arm/i.MX28 the leds connected to a pwm are still broken and it's mor=
e
than three years ago that I came up with these patches. I still conside=
r
them to do the right thing and they fix a real bug.

Old threads to this topic include:

	http://thread.gmane.org/gmane.linux.kernel/1381289
	http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D28=
2596
	http://thread.gmane.org/gmane.linux.pwm/1749

Uwe Kleine-K=C3=B6nig (2):
  pwm/doc: Clearify that the pin state after pwm_disable is undefined
  leds/pwm: Don't disable pwm when setting brightness to 0

 Documentation/pwm.txt   |  5 +++++
 drivers/leds/leds-pwm.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

--=20
2.1.4

