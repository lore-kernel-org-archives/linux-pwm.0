From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Fri, 30 Oct 2015 15:41:40 +0800
Message-ID: <1446190900.17558.16.camel@mtksdaap41>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
 <1446133259.3274.52.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446133259.3274.52.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Hpilipp,

On Thu, 2015-10-29 at 16:40 +0100, Philipp Zabel wrote:
> Hi YH,
> 
> Am Donnerstag, den 22.10.2015, 23:12 +0800 schrieb YH Huang:
> > In the case of the panel disabled by the bootloader,
> > your patch still has the following code and always enables the backlight
> > in the probe function.
> > pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> 
> You are right.
> 
> > What do you think if I remove these two lines in my patch?
> > if (pb->enable_gpio)
> > 	gpiod_direction_output(pb->enable_gpio, 0);
> 
> That won't work if the gpio is still configured as input. How about I
> add the GPIOD_ASIS change to my patch you remove that and the above from
> yours?

I revise these two lines 
if (pb->enable_gpio)
	gpiod_direction_output(pb->enable_gpio, 0);
into
if (pb->enable_gpio) {
	if(gpiod_get_value(pb->enable_gpio) == 0)
		gpiod_direction_output(pb->enable_gpio, 0);
	else
		gpiod_direction_output(pb->enable_gpio, 1);
}

I am not sure what "phandle" is working for.
My change is like your patch but remove the "phandle related" and
"gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT".
Do we really need these?

Also, do you think it is right that I do the "pwm_enable(pb->pwm);"
before "gpiod_set_value(pb->enable_gpio, 1);" in power on function?

Regards,
YH Huang
