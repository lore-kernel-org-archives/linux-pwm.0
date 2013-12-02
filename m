From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC] pwm: Add Freescale FTM PWM driver support
Date: Mon, 2 Dec 2013 12:34:06 +0000
Message-ID: <20131202123406.GK12952@e106331-lin.cambridge.arm.com>
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Alison Wang <b18965@freescale.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "r65073@freescale.com" <r65073@freescale.com>, Jingchang Lu <b35083@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linar>
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 02, 2013 at 10:15:09AM +0000, Xiubo Li wrote:
> The FTM PWM device can be found on Vybrid VF610 Tower and
> Layerscape LS-1 SoCs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> 
> I'm sending the RFC patch about the FTM IP block registers read and write
> endian fix for comments and more parcticed ideas.
> 
> In Vybird VF610 Tower, all the IP blocks expect LE data. In the LS-1, some of
> the IP blocks expect LE data, while others expect BE data. And the CPU always
> operates in LE mode in these two platforms.

Could you elaborate on "expect BE data" please? Is this all registers
within a given device, or a subset thereof? Are there data structrues
involved (i.e. buffers)?

> 
> So now I must take care of all these two cases. I'm not very sure if there is
> other better ways to resolve this problem. In this patch I have implemented
> two functions fsl_pwm_readl() and fsl_pwm_writel() to replace readl() and
> writel(). At the same time there should add one "endianess" property in the DT
> file.

If you're adding DT properties, binding updates are helpful to describe
their intended use.

[...]

> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc, void __iomem *reg)
> +{
> +       u32 val;
> +
> +       val = __raw_readl(reg);
> +
> +       if (fpc->endianess == FTM_BIG)
> +               return be32_to_cpu(val);
> +       else
> +               return le32_to_cpu(val);
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 val,
> +               void __iomem *reg)
> +{
> +       if (fpc->endianess == FTM_BIG)
> +               val = cpu_to_be32(val);
> +       else
> +               val = cpu_to_le32(val);
> +
> +       __raw_writel(val, reg);
> +}

Using the __raw variants also loses you the memory barriers. Does this
create any ordering issues in the rest of the driver?

[...]

> +static int fsl_pwm_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       const char *endianess;
> +       struct fsl_pwm_chip *fpc;
> +       struct resource *res;
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> +       if (!fpc)
> +               return -ENOMEM;
> +
> +       mutex_init(&fpc->lock);
> +
> +       fpc->chip.dev = &pdev->dev;
> +
> +       ret = fsl_pwm_parse_clk_ps(fpc);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (of_property_read_string(np, "endianess", &endianess))
> +               pr_warning("missing \"endianess\" property, "
> +                               "the FTM IP block is little "
> +                               "endian as default\n");
> +       else if (!strcmp("big", endianess))
> +               fpc->endianess = FTM_BIG;

Please don't do this.

One option is to have a new compatible string -- a big-endian device
can't be poked in the same way as its little-endian variants, so they're
not compatible. You can then associate some data with the compatible
strings to figure out which accessors to use.

If you really want this to be a separate property, make it a boolean
property (e.g. "fsl,big-endian", which you can read with
of_property_read_bool. There's no need for this to be a string.

I'd prefer the compatible string option.

Thanks,
Mark.
