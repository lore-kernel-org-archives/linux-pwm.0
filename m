Return-Path: <linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 3 Sep 2013 07:40:06 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F8D57@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
 <20130830174909.GF30088@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827F785F@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130902085630.GS30088@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827F7C59@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130903065832.GB30088@pengutronix.de>
In-Reply-To: <20130903065832.GB30088@pengutronix.de>
Content-Language: en-US
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guo Shawn-R65073 <r65073@freescale.com>, Lu Jingchang-B35083 <B35083@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "rob@landley.net" <rob@landley.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> Subject: Re: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
> 
> On Tue, Sep 03, 2013 at 04:17:09AM +0000, Xiubo Li-B47053 wrote:
> > > Subject: Re: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
> > >
> > > You simply don't need the available field. You don't need to track
> > > whether they are available. If a user enables a pwm which is not
> > > routed out of the SoC (disabled in the iomux) simply nothing will
> > > happen except for a slightly increased power consumption.
> > >
> > If the there is not need to explicitly specify the channels are
> > available or not, so there is no doubt that the 'available' field will
> > be dropt.  Why I added this here is because that the 4th and 5th
> > channels' pinctrls are used as UART TX and RX as I have mentioned
> > before, so here if you configure these two pinctrls, the UART TX and
> > RX will be polluted, there maybe some other cases like this.
> 
> If you misconfigure your iomux then usually unexptected things happen.
> That is not the problem of the PWM driver, but the problem of the one
> writing the devicetree. The kernel will print a message for conflicting
> iomux settings. That should be hint enough to fix it.
> 

That sounds good.
Actully there isn't any conflicting messages will be printed.

I will think it over.


--
Best Regards,
Xiubo 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
