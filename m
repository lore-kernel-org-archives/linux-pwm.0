From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] pwm: make pwm_apply_state_debug static
Date: Thu, 2 Apr 2020 16:10:00 +0200
Message-ID: <20200402141000.6y2lzjn4ei7hd67w@pengutronix.de>
References: <20200402065718.32433-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBOKD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 10:10:03 -0400
Content-Disposition: inline
In-Reply-To: <20200402065718.32433-1-yanaijie@huawei.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jason Yan <yanaijie@huawei.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org

On Thu, Apr 02, 2020 at 02:57:18PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
> not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks sensible:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
