Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbfJPLGG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so4415961wmc.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:05 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 13:05:58 +0200
Message-Id: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 0/3] pwm: stm32: Minor cleanups
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Hi,

Looking at Fabrice's STM32 patches I noticed that we're now passing the
breakinput values (u32) into a function via int parameters. The easiest
way to fix this inconsistency is by just passing a pointer to the break
input structure. There's some preparatory work here that makes the code
slightly more readable, in my opinion. I ended up squashing two patches
into one in v2 because the second patch from v1 is already addressed in
patch 1 of v2. I've added a patch in v2 that validates device tree data
for breakinput as suggested by Uwe.

Lee, patch 1 of this small series touches the MFD header for the STM32
timers, but there's no good way to separate the patches, so if you could
provide an Acked-by on that patch so that I can take it through the PWM
tree along with the rest, that'd be great.

Thierry

Thierry Reding (3):
  pwm: stm32: Remove clutter from ternary operator
  pwm: stm32: Pass breakinput instead of its values
  pwm: stm32: Validate breakinput data from DT

 drivers/pwm/pwm-stm32.c          | 36 +++++++++++++++++---------------
 include/linux/mfd/stm32-timers.h | 12 ++++-------
 2 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.23.0
