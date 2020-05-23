From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 30/32] pwm: hibvt: do some cleanup
Date: Sat, 23 May 2020 19:44:00 +0200
Message-ID: <20200523174400.tzptmraqyn3uqrvf@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-30-tiny.windzz@gmail.com>
 <20200220204152.p6rublsssifvvnvk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200220204152.p6rublsssifvvnvk@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Yangtao Li <tiny.windzz@gmail.com>, thierry.reding@gmail.com
Cc: alexandre.belloni@bootlin.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org, festevam@gmail.com, f.fainelli@gmail.com, shc_work@mail.ru, khilman@baylibre.com, wens@csie.org, jonathanh@nvidia.com, linux-rockchip@lists.infradead.org, ludovic.desroches@microchip.com, bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com, slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org, rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org, vz@mleia.com, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux@prisktech.co.nz, palmer@dabbelt.com, kernel@pengutronix.de, shawnguo@kernel.org, claudiu.beznea@microchip.com, nsaenzjulienne@suse.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Feb 20, 2020 at 09:41:52PM +0100, Uwe Kleine-K=F6nig wrote:
> On Sun, Dec 29, 2019 at 08:06:08AM +0000, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
> > 'i' and 'ret' are variables of the same type and there is no
> > need to use two lines.
> =

> I think I wouldn't have merged these two lines, but I don't feel strong
> here. The other 31 patches are clean replacements.
> =

> But I also don't think respining just for this minor thing is worth the
> effort, so:
> =

> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> =

> for the whole series. (Not sure it is sensible to ack each patch
> individually, @Thierry, tell me if this simplifies things for you.)

I took a deeper look now and added Reviewed-by for all other patches to
ease application. So doing the same here:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

FTR: I'd do the following now:

	for patch in 1216003 1216065 1216063 1216005 1216062 1216061 1216059 12160=
57 1216054 1216056 1216051 1216050 1216048 1216010 1216044 1216046 1216042 =
1216041 1216036 1216037 1216034 1216032 1216030 1216013 1216029 1216025 121=
6026 1216024 1216015 1216021 1216017 1216019; do

		pwclient git-am -m -s $patch && pwclient update -s "Accepted" -c "$(git r=
ev-parse HEAD)" $patch || break
	done

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
