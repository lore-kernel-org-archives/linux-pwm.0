From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pwm: berlin: fix build warning
Date: Tue, 06 Oct 2015 21:56:20 +0200
Message-ID: <13015728.LECQI3jOWk@wuerfel>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com> <1443797990-10809-3-git-send-email-antoine.tenart@free-electrons.com> <20151005143015.GB27759@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005143015.GB27759@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com
List-Id: linux-pwm@vger.kernel.org

The newly added berlin pwm driver causes a build warning:

drivers/pwm/pwm-berlin.c: In function 'berlin_pwm_config':
drivers/pwm/pwm-berlin.c:61:32: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);

This changes the prototype of the to_berlin_pwm_chip() the way it
was meant to be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Monday 05 October 2015 16:30:15 Thierry Reding wrote:
> On Fri, Oct 02, 2015 at 04:59:47PM +0200, Antoine Tenart wrote:
> > Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> > controller has 4 channels.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |   9 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-berlin.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 231 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-berlin.c
> 
> Applied, with minor tweaks, thanks.

Apparently the tweak has failed 

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index a390de6a760f..97933d3b2cc4 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -33,7 +33,7 @@ struct berlin_pwm_chip {
 	void __iomem *base;
 };
 
-static inline to_berlin_pwm_chip(struct pwm_chip *chip)
+static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of((chip), struct berlin_pwm_chip, chip);
 }
