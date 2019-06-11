From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 02/14] pwm: meson: use devm_clk_get_optional() to get
 the input clock
Date: Tue, 11 Jun 2019 17:37:24 +0200
Message-ID: <20190611153724.fg34zp6vof7lpcgl@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190608180626.30589-3-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Jun 08, 2019 at 08:06:14PM +0200, Martin Blumenstingl wrote:
> Simplify the code which fetches the input clock for a PWM channel by
> using devm_clk_get_optional().
> This comes with a small functional change: previously all errors except
> EPROBE_DEFER were ignored. Now all other errors are also treated as
> errors. If no input clock is present devm_clk_get_optional() will return
> NULL instead of an error which matches the behavior of the old code.
> =

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Nitpick: Put your S-o-b last. Otherwise this ends as

	Sgned-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
	Rviewed-by: Neil Armstrong <narmstrong@baylibre.com>
	Sgned-off-by: Thierry Reding <thierry.reding@gmail.com>

and this implies that Thierry added Neil's tag.  (Typos are done on
purpose to not confuse patchwork.)

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
