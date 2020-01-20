From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] pwm: remove set but not set variable 'pwm'
Date: Mon, 20 Jan 2020 15:21:38 +0100
Message-ID: <20200120142138.blwyvtjw23tm7ike@pengutronix.de>
References: <20200120115143.35571-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgATOVl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:21:41 -0500
Content-Disposition: inline
In-Reply-To: <20200120115143.35571-1-yukuai3@huawei.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, zhengbin13@huawei.com, yi.zhang@huawei.com

On Mon, Jan 20, 2020 at 07:51:43PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
> drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but
> not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed. In that case, hold and release
> the lock 'pac->lock' can be removed since nothing will be done between
> them.
> 
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
