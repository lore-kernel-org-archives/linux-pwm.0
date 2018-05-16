From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and PWM due for the v4.18
 merge window
Date: Wed, 16 May 2018 09:19:10 +0100
Message-ID: <20180516081910.GF5130@dell>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, thierry.reding@gmail.com, benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Enjoy!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-v4.18

for you to fetch changes up to ab3a897847834bf3e864fb07b733c444895a24ba:

  pwm: stm32: Use input prescaler to improve period capture (2018-05-16 09:11:19 +0100)

----------------------------------------------------------------
Immutable branch between MFD and PWM due for the v4.18 merge window

----------------------------------------------------------------
Fabrice Gasnier (4):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture

 drivers/mfd/stm32-timers.c       | 201 +++++++++++++++++++++++++++++-
 drivers/pwm/pwm-stm32.c          | 257 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-timers.h |  58 +++++++++
 3 files changed, 514 insertions(+), 2 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
