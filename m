From: Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [RFC PATCH 0/4] pwm: sun4i: Properly turn pwm off and fix stuck output state
Date: Tue, 17 Mar 2020 16:59:02 +0100
Message-ID: <20200317155906.31288-1-dev@pascalroeleven.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from web0081.zxcs.nl ([185.104.29.10]:54488 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQP7z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 11:59:55 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-sunxi@googlegroups.com, Pascal Roeleven <dev@pascalroeleven.nl>

Hi all,

For the last few days I've been debugging a lot to get pwm working again since
recent changes in 5.6-rc1 broke it for me.

Testing shows the pwm controller crashes (or the output gets stuck) when the
period register is written when the channel is disabled while the clock gate is
still on. Usually after multiple writes, but one write can also lead to
unpredictable behaviour. Patch 3 and 4 fix this.

Patch 2 contains a fix which wouldn't completely turn off the pwm if the
output is disabled. The clock gate needs to stay on for at least one more
period to ensure the output is properly disabled. This issue has been around
for a long time but has probably stayed unnoticed because if the duty_cycle is
also changed to 0, you can't tell the difference.

Patch 1 removes some leftovers which aren't needed anymore.

Obviously these patches work for my device, but I'd like to hear your opinion
if any of these changes make sense. After days, this one is a bit blurry for me.

Thanks to Uwe for some help with debugging.

Pascal.

Pascal Roeleven (4):
  pwm: sun4i: Remove redundant needs_delay
  pwm: sun4i: Disable pwm before turning off clock gate
  pwm: sun4i: Move delay to function
  pwm: sun4i: Delay after writing the period

 drivers/pwm/pwm-sun4i.c | 53 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

-- 
2.20.1
