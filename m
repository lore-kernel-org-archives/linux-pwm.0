From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 01/14] pwm: meson: unify the parameter list of
 meson_pwm_{enable,disable}
Date: Tue, 11 Jun 2019 17:29:53 +0200
Message-ID: <20190611152953.5pitafag62dhk6vu@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608180626.30589-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

Hello Martin,

On Sat, Jun 08, 2019 at 08:06:13PM +0200, Martin Blumenstingl wrote:
> This is a preparation for a future cleanup. Pass struct pwm_device
> instead of passing the individual values required by each function as
> these can be obtained for each struct pwm_device instance.
> 
> As a nice side-effect the driver now uses "switch (pwm->hwpwm)"
> everywhere. Before some functions used "switch (id)" while others used
> "switch (pwm->hwpwm)".
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
