From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pwm: fix Broadcom BCM7038 PWM driver
Date: Tue, 06 Oct 2015 21:59:25 +0200
Message-ID: <6796852.Ynn1zMqb4r@wuerfel>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com> <20151005151415.GE27759@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005151415.GE27759@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar
List-Id: linux-pwm@vger.kernel.org

The newly added pwm-brcmstb driver fails to build if CONFIG_PM_SLEEP
is enabled:

drivers/pwm/pwm-brcmstb.c: In function 'brcmstb_pwm_suspend':
drivers/pwm/pwm-brcmstb.c:309:42: error: 'dev' undeclared (first use in this function)
  struct brcmstb_pwm *p = dev_get_drvdata(dev);

This changes the name of the function argument to match its user.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Monday 05 October 2015 17:14:15 Thierry Reding wrote:
> On Mon, Sep 14, 2015 at 04:47:04PM -0700, Florian Fainelli wrote:
> > Florian Fainelli (2):
> >   Documentation: dt: add Broadcom BCM7038 PWM controller binding
> >   pwm: Add Broadcom BCM7038 PWM controller support
> 
> I've applied both of these patches with a couple of stylistic changes.

As in the pwm-berlin driver, one of the fixups was broken.

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 083e3ef5b8e5..423ce087cd9c 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -304,7 +304,7 @@ static int brcmstb_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int brcmstb_pwm_suspend(struct device *d)
+static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
@@ -313,7 +313,7 @@ static int brcmstb_pwm_suspend(struct device *d)
 	return 0;
 }
 
-static int brcmstb_pwm_resume(struct device *d)
+static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
