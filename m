From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [pwm:for-4.9/drivers 2/9] drivers/pwm/pwm-berlin.c:245:35:
 error: 'struct berlin_pwm_chip' has no member named 'chips'
Date: Tue, 6 Sep 2016 13:35:31 +0800
Message-ID: <20160906133531.367129f0@xhacker>
References: <201609051807.8q1Dh6WZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43550 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752190AbcIFFkC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 01:40:02 -0400
In-Reply-To: <201609051807.8q1Dh6WZ%fengguang.wu@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>



On Mon, 5 Sep 2016 18:37:13 +0800 kbuild test robot  wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-4.9/drivers
> head:   e63ed23775362a6e1a867dc2f75ebbf4e3a8d4d2
> commit: fd47f104003c629d0ec6be4c2ead90191c184a23 [2/9] pwm: berlin: Add suspend/resume support
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout fd47f104003c629d0ec6be4c2ead90191c184a23
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pwm/pwm-berlin.c: In function 'berlin_pwm_suspend':
> >> drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'  
>       channel = pwm_get_chip_data(&pwm->chips.pwms[i]);
>                                       ^


Thanks for information. Below patch can fix it.

Hi Thierry,

a separate fix or amend the commit, which do you prefer?

Thanks,
Jisheng


8<----------------
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 31b2ee3..01339c1 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -242,7 +242,7 @@ static int berlin_pwm_suspend(struct device *dev)
 	for (i = 0; i < pwm->chip.npwm; i++) {
 		struct berlin_pwm_channel *channel;
 
-		channel = pwm_get_chip_data(&pwm->chips.pwms[i]);
+		channel = pwm_get_chip_data(&pwm->chip.pwms[i]);
 		if (!channel)
 			continue;
 
