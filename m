From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 4/6] pwm: sun4i: Always calculate params when applying
 new parameters
Date: Thu, 21 Nov 2019 22:11:43 +0100
Message-ID: <20191121211142.kuhcxpxudt3tod4p@pengutronix.de>
References: <20191121195902.6906-1-peron.clem@gmail.com>
 <20191121195902.6906-5-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191121195902.6906-5-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Nov 21, 2019 at 08:59:00PM +0100, Clément Péron wrote:
> Bypass mode will require to be re-calculated when the pwm state
> is changed.
> 
> Remove the condition so pwm_sun4i_calculate is always called.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

When applying this patch and looking at it using git show -b it is
obvious the patch does exactly what is promised here. (Apart from the
introduced empty line in the last hunk which is ok in my book.)

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
