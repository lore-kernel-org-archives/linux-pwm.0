From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: pca9685: use gpio core provided macro
 GPIO_LINE_DIRECTION_OUT
Date: Wed, 11 Mar 2020 17:43:57 +0100
Message-ID: <20200311164357.44bfscijrjfnjymk@pengutronix.de>
References: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgCKQn7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 12:43:59 -0400
Content-Disposition: inline
In-Reply-To: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: thierry.reding@gmail.com, s.trumtrar@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:22:20PM +0530, Rishi Gupta wrote:
> GPIO core recently added macro to uniformly specify direction
> of a GPIO Line, so use it.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
