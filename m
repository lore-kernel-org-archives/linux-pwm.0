From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [RFC] pwm: Add Freescale FTM PWM driver support
Date: Tue, 3 Dec 2013 04:02:48 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828E374B@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
 <20131202123406.GK12952@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131202123406.GK12952@e106331-lin.cambridge.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jingchang Lu <jingchang.lu@freescale.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, grant
List-Id: linux-pwm@vger.kernel.org

> > I'm sending the RFC patch about the FTM IP block registers read and
> > write endian fix for comments and more parcticed ideas.
> >
> > In Vybird VF610 Tower, all the IP blocks expect LE data. In the LS-1,
> > some of the IP blocks expect LE data, while others expect BE data. And
> > the CPU always operates in LE mode in these two platforms.
> 
> Could you elaborate on "expect BE data" please? Is this all registers
> within a given device, or a subset thereof?
> Are there data structures involved (i.e. buffers)?
>

It actually means big-endian mode, and it's all the registers and hasn't any
buffers or descriptors involved within FTM IP block.
But maybe in other IP blocks, such as eDMA and USB, should consider about the
buffers/descriptors issue.


> >
> > So now I must take care of all these two cases. I'm not very sure if
> > there is other better ways to resolve this problem. In this patch I
> > have implemented two functions fsl_pwm_readl() and fsl_pwm_writel() to
> > replace readl() and writel(). At the same time there should add one
> > "endianess" property in the DT file.
> 
> If you're adding DT properties, binding updates are helpful to describe
> their intended use.
> 

Yes, that surely will be added later.


> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc, void
> > +__iomem *reg) {
> > +       u32 val;
> > +
> > +       val = __raw_readl(reg);
> > +
> > +       if (fpc->endianess == FTM_BIG)
> > +               return be32_to_cpu(val);
> > +       else
> > +               return le32_to_cpu(val); }
> > +
> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 val,
> > +               void __iomem *reg)
> > +{
> > +       if (fpc->endianess == FTM_BIG)
> > +               val = cpu_to_be32(val);
> > +       else
> > +               val = cpu_to_le32(val);
> > +
> > +       __raw_writel(val, reg);
> > +}
> 
> Using the __raw variants also loses you the memory barriers. Does this
> create any ordering issues in the rest of the driver?
> 

No, I had checked about this, so I just droped them.
Maybe it will be much better and safer if there are some memory barriers.



> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +       int ret;
> > +       const char *endianess;
> > +       struct fsl_pwm_chip *fpc;
> > +       struct resource *res;
> > +       struct device_node *np = pdev->dev.of_node;
> > +
> > +       fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> > +       if (!fpc)
> > +               return -ENOMEM;
> > +
> > +       mutex_init(&fpc->lock);
> > +
> > +       fpc->chip.dev = &pdev->dev;
> > +
> > +       ret = fsl_pwm_parse_clk_ps(fpc);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (of_property_read_string(np, "endianess", &endianess))
> > +               pr_warning("missing \"endianess\" property, "
> > +                               "the FTM IP block is little "
> > +                               "endian as default\n");
> > +       else if (!strcmp("big", endianess))
> > +               fpc->endianess = FTM_BIG;
> 
> Please don't do this.
> 
> One option is to have a new compatible string -- a big-endian device can't
> be poked in the same way as its little-endian variants, so they're not
> compatible. You can then associate some data with the compatible strings to
> figure out which accessors to use.
> 

Do you mean:
+ static const struct of_device_id fsl_pwm_dt_ids[] = {
+        { .compatible = "fsl,vf610-ftm-pwm,big-endian", },
+        { .compatible = "fsl,vf610-ftm-pwm,little-endian", },
+        { /* sentinel */ }
+ };  ?

Or just adding one property in DT file likes:
			pwm0: pwm@40038000 {
				compatible = "fsl,vf610-ftm-pwm";
				#pwm-cells = <3>;
				reg = <0x40038000 0x1000>;
				clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
				clocks = <&clks VF610_CLK_FTM0>,
					<&clks VF610_CLK_FTM0_FIX_SEL>,
					<&clks VF610_CLK_FTM0_EXT_SEL>;
+				big-endian;       ---> both registers and buffers/descriptors
Or 
+				big-endian-regs;  ---> registers
+				big-endian-desc;  ---> buffers or descriptors
				status = "disabled";
			};
And then in FTM driver probe function adds:
+        if (of_get_property(np, "big-endian", NULL))
+                fpc->be_reg = fpc->be_desc = 1;
+        else if (of_get_property(np, "big-endian-regs", NULL))
+                fpc->be_reg = 1;
+        else if (of_get_property(np, "big-endian-desc", NULL))
+                fpc->be_desc = 1;

In this case, if all of the following properties is absent, that means they all are
operated in little-endian mode.

"big-endian"
"big-endian-regs"
"big-endian-desc"

--
Best Regards,
