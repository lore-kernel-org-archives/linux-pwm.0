From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 03/14] pwm: meson: use GENMASK and FIELD_PREP for the
 lo and hi values
Date: Tue, 11 Jun 2019 17:38:08 +0200
Message-ID: <20190611153808.oljoea7ohzpm26zy@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-4-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608180626.30589-4-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

On Sat, Jun 08, 2019 at 08:06:15PM +0200, Martin Blumenstingl wrote:
> meson_pwm_calc() ensures that "lo" is always less than 16 bits wide
> (otherwise it would overflow into the "hi" part of the REG_PWM_{A,B}
> register).
> Use GENMASK and FIELD_PREP for the lo and hi values to make it easier to
> spot how wide these are internally. Additionally this is a preparation
> step for the .get_state() implementation where the GENMASK() for lo and
> hi becomes handy because it can be used with FIELD_GET() to extract the
> values from the register REG_PWM_{A,B} register.
> 
> No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
