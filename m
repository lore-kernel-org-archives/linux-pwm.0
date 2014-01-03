From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
Date: Fri, 3 Jan 2014 15:08:26 -0800
Message-ID: <20140103230826.GB13489@core.coreip.homeip.net>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
 <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "bpringlemeir@nbsps.com" <bpringlemeir@nbsps.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jingchang Lu <jingchang.lu@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Huan Wang <Huan.Wang@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 03, 2014 at 09:16:06AM +0000, Li.Xiubo@freescale.com wrote:
> Hi Dmitry,
> 
> > Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
> > 
> > Hi Xiubo,
> > 
> > On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> > > +
> > > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > > +					       enum fsl_pwm_clk index)
> > > +{
> > 
> > Why do you declare this (and other module-local) function as inline?
> > It is usually better let compiler decide if given function should be
> > inlined or not.
> > 
> 
> Could the compiler know when the given function should be inlined by
> not declare it?

Yes.

> And when will be inlined ?

When it makes sense to do so from compiler's point of view: i.e. it is
smallish or with single call site and there are enough registers, etc,
etc.

Thanks.

-- 
Dmitry
