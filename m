From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCHv2 0/2] pwm: sunxi: give the pwm IP block more time
Date: Thu, 25 Aug 2016 19:50:09 +0200
Message-ID: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:33462 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755734AbcHYRut (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 25 Aug 2016 13:50:49 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>

Hi all,

last year I've sent out this patch series and there was little technical
discussion, so hopefully we can rekindle it.

This patch series fixes 2 issues. For one, we add a delay between disabling
the PWM hardware block and removing the clock, this to yield the PWM hardware
time to actually finish it's PWM and finish in the proper state. If we do not
do this, the output may stay high and may overload speakers for example.

The other issue might need a little more discussion. It also yields the PWM
hardware some extra time. When changing the config, we enable the clock
together with the parameters for the PWM. Sometimes however, the PWM IP core
has not had the time yet to actually set the ready bit. By first enabling
the gate, and then change things, the IP has time to do its thing. The PWM
block has probably done its thing even after the writel has returned. So an
extra delay (of one bus clock cycle?) is overkill.

Changes since v1:
	- Split patch series into several smaller patch series
	- Added driver author

Olliver Schinagl (2):
  pwm: sunxi: allow the pwm to finish its pulse before disable
  pwm: sunxi: Yield some time to the pwm-block to become ready

 drivers/pwm/pwm-sun4i.c | 54 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

-- 
2.8.1
