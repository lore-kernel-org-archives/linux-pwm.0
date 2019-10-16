Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42419 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJPHiq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so26708854wrw.9
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:45 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 09:38:39 +0200
Message-Id: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 0/3] pwm: stm32: Minor cleanups
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Hi,

Looking at Fabrice's STM32 patches I noticed that we're now passing the
breakinput values (u32) into a function via int parameters. The easiest
way to fix this inconsistency is by just passing a pointer to the break
input structure. There's some preparatory work here that makes the code
slightly more readable, in my opinion, but it's really marginal, so I'm
not terribly thrilled by this series in retrospect.

If nobody else thinks this is a big improvement I'll just scrap it.

Thierry

Thierry Reding (3):
  pwm: stm32: Remove clutter from ternary operator
  pwm: stm32: Remove confusing bitmask
  pwm: stm32: Pass breakinput instead of its values

 drivers/pwm/pwm-stm32.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.23.0
