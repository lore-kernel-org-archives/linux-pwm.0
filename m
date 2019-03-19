From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V6 4/5] ARM: dts: imx7ulp: Add pwm0 support
Date: Tue, 19 Mar 2019 07:54:34 +0100
Message-ID: <20190319065434.mbadba7fi2hdncf4@pengutronix.de>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-5-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1552977898-5590-5-git-send-email-Anson.Huang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm->
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 19, 2019 at 06:50:26AM +0000, Anson Huang wrote:
> Add i.MX7ULP EVK board PWM0 support.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V5:
> 	- change #pwm-cells to 3.
> ---
>  arch/arm/boot/dts/imx7ulp-evk.dts | 12 ++++++++++++
>  arch/arm/boot/dts/imx7ulp.dtsi    | 10 ++++++++++

IMHO the change to the evk.dts belongs into the last patch.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
