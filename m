From: Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v5 07/13] dt-bindings: pwm: add a property "num-pwms"
Date: Thu, 12 Sep 2019 09:33:33 +0800
Message-ID: <1568252013.4102.1.camel@mtksdccf07>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
         <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
         <20190827183924.GA24178@bogus>
         <20190902160445.fitoa65t4ndzjq6v@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190902160445.fitoa65t4ndzjq6v@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2019-09-02 at 18:04 +0200, Uwe Kleine-König wrote:
> On Tue, Aug 27, 2019 at 01:39:24PM -0500, Rob Herring wrote:
> > On Thu, Aug 22, 2019 at 02:58:37PM +0800, Sam Shih wrote:
> > > From: Ryder Lee <ryder.lee@mediatek.com>
> > 
> > The subject should indicate this is for Mediatek.
> > 
> > > 
> > > This adds a property "num-pwms" in example so that we could
> > > specify the number of PWM channels via device tree.
> > > 
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Changes since v5:
> > > - Add an Acked-by tag
> > > - This file is original v4 patch 5/10
> > > (https://patchwork.kernel.org/patch/11102577/)
> > > 
> > > Change-Id: I429048afeffa96f3f14533910efe242f88776043
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > index 991728cb46cb..ea95b490a913 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > @@ -14,12 +14,12 @@ Required properties:
> > >                  has no clocks
> > >     - "top": the top clock generator
> > >     - "main": clock used by the PWM core
> > > -   - "pwm1-8": the eight per PWM clocks for mt2712
> > > -   - "pwm1-6": the six per PWM clocks for mt7622
> > > -   - "pwm1-5": the five per PWM clocks for mt7623
> > > +   - "pwm1-N": the PWM clocks for each channel
> > > +   where N starting from 1 to the maximum number of PWM channels
> > 
> > Once converted to schema, you are going to be back to listing them out.
> > 
> > >   - pinctrl-names: Must contain a "default" entry.
> > >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> > >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > > + - num-pwms: the number of PWM channels.
> > 
> > You can't add new required properties without breaking compatibility. 
> > 
> > You already have to imply the number of channels from the compatible (or 
> > number of clocks) and you have to keep doing so to maintain 
> > compatibility, so why not just keep doing that for new chips?
> 
> This was a suggestion by me. The driver still handles compatibility
> (i.e. falls back to the number of PWMs that was implied by the
> compatible before). Given that there are various drivers that all solve
> the same problem (i.e. different variants with different number of PWMs)
> I thought it would be a good idea to introduce a property in the device
> tree that specifies this number.
> 
> Only for newly introduced compatibles the num-pwms property is really
> required. Differentiating the ones that need it and the ones that don't
> seems over-engineered to me.
> 
> (BTW, using the number of clks doesn't really work because there are
> also some variants without clocks. It is still under discussion if in
> this case dummy-clocks should be provided IIRC.)
> 
> Best regards
> Uwe
> 


Any conclusions ? 

just a friendly reminder :)


regards Sam
