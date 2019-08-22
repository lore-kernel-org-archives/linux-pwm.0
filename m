From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: pwm-mediatek: Add MT8516 SoC support
Date: Thu, 22 Aug 2019 11:18:10 +0200
Message-ID: <20190822091810.5t3inn56npdvwnfy@pengutronix.de>
References: <20190805125848.15751-1-fparent@baylibre.com>
 <20190805125848.15751-2-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190805125848.15751-2-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Aug 05, 2019 at 02:58:48PM +0200, Fabien Parent wrote:
> Add the compatible and the platform data to support PWM on the MT8516
> SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The change looks fine, there is however another series currently waiting
for application for this driver that conflicts with this one (I think).

Maybe it would be sensible to join your forces and produce a single
series without conflicts?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
