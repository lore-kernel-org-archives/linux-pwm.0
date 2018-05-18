From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] Fix STM32 PWM capture build with COMPILE_TEST
Date: Fri, 18 May 2018 17:24:02 +0200
Message-ID: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Build issue has been identified when COMPILE_TEST=y and MFD_STM32_TIMERS=n:
https://lkml.org/lkml/2018/5/17/825
- First patch introduces a stub routine in mfd header file
- Sub-sequent patch solves warning in pwm-stm32 with these configs

Fabrice Gasnier (2):
  mfd: stm32-timers: fix pwm-stm32 linker issue with COMPILE_TEST
  pwm: stm32: initialize raw local variables

 drivers/pwm/pwm-stm32.c          |  2 +-
 include/linux/mfd/stm32-timers.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1
