From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Date: Tue, 9 Apr 2019 23:02:48 -0300
Message-ID: <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com> <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 9, 2019 at 10:47 PM Anson Huang <anson.huang@nxp.com> wrote:

>  #include "imx7ulp.dtsi"
> +#include <dt-bindings/pwm/pwm.h>

This inclusion is not needed here as PWM_POLARITY_INVERTED is not used
in this dts.
