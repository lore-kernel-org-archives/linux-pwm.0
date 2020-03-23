From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date: Mon, 23 Mar 2020 10:35:19 +0100
Message-ID: <20200323093519.krno3znzqbptrwxj@pengutronix.de>
References: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
 <20200323092424.22664-2-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41037 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCWJfX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:35:23 -0400
Content-Disposition: inline
In-Reply-To: <20200323092424.22664-2-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:54:23PM +0530, Rayagonda Kokatanur wrote:
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.

The idea I wanted to transport with my question about how this problem
was found is that the commit log is amended with this information. This
is important information as it helps people having to decide if this
change should be backported. Also it would be great to know if this can
really make the kernel crash or if (e.g.) said clock cannot be off in
practise.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
