From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Date: Fri, 18 Jan 2019 18:01:09 +0800
Message-ID: <1547805669.8969.4.camel@mtkswgap22>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <20190118075925.noilab6glzm3cig6@pengutronix.de>
         <1547804574.8124.6.camel@mtkswgap22>
         <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 2019-01-18 at 10:53 +0100, Uwe Kleine-König wrote:
> Hello Ryder,
> 
> On Fri, Jan 18, 2019 at 05:42:54PM +0800, Ryder Lee wrote:
> > On Fri, 2019-01-18 at 08:59 +0100, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
> > > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > > list of compatibles with no differences for the same driver.
> > > > 
> > > > Thus, the driver should have backwards compatibility to older DTs.
> > > 
> > > I still think Thierry should bless "num-pwms" without vendor prefix.
> > 
> > Okay.
> > 
> > > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > ---
> > > > Changes since v1: add some checks for backwards compatibility.
> > > > ---
> > > >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> > > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > > index eb6674c..81b7e5e 100644
> > > > --- a/drivers/pwm/pwm-mediatek.c
> > > > +++ b/drivers/pwm/pwm-mediatek.c
> > > > @@ -55,7 +55,7 @@ enum {
> > > >  };
> > > >  
> > > >  struct mtk_pwm_platform_data {
> > > 
> > > Unrelated to this patch: This name is bad. This struct is not used as
> > > platform_data and so should better be named mtk_pwm_of_data. While at
> > > criticizing existing stuff: I'd prefer pwm_mediatek as common prefix to
> > > match the filename.
> > 
> > I think we can take care about that in another patch.
> 
> That's what I wanted to say, right. Do you follow up?

Yes, I will do that.

> > > > -	unsigned int num_pwms;
> > > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> > > 
> > > I'd drop this comment in favour of a runtime warning.
> > 
> > Sorry, I can't get you here.
> 
> I'd do a
> 
> 	dev_warn(dev, "dt didn't specify number of PWMs, falling back to %d\n", pc->soc->num_pwms);
> 
> to make people aware that updating the dt would be nice.

Okay!

Thanks
Ryder
