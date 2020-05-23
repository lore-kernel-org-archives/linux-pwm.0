From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 27/32] pwm: clps711x: convert to
 devm_platform_ioremap_resource
Date: Sat, 23 May 2020 19:17:03 +0200
Message-ID: <20200523171703.hbwe2qzmlkemgc7a@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-27-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191229080610.7597-27-tiny.windzz@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: alexandre.belloni@bootlin.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, thierry.reding@gmail.com, linux-riscv@lists.infradead.org, festevam@gmail.com, f.fainelli@gmail.com, shc_work@mail.ru, khilman@baylibre.com, wens@csie.org, jonathanh@nvidia.com, linux-rockchip@lists.infradead.org, ludovic.desroches@microchip.com, bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com, slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org, rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org, vz@mleia.com, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux@prisktech.co.nz, palmer@dabbelt.com, kernel@pengutronix.de, shawnguo@kernel.org, claudiu.beznea@microchip.com, nsaen
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sun, Dec 29, 2019 at 08:06:05AM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> =

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
