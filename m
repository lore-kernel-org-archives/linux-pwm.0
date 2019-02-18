From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Date: Mon, 18 Feb 2019 14:36:58 -0600
Message-ID: <20190218203658.GA20434@bogus>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> 
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" in example so that we could
> > set the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> > Changes since v1: add a Reviewed-by tag.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 991728c..f9e2d1f 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -20,6 +20,7 @@ Required properties:
> >   - pinctrl-names: Must contain a "default" entry.
> >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > + - mediatek,num-pwms: the number of PWM channels.
> >  
> >  Example:
> >  	pwm0: pwm@11006000 {
> > @@ -37,4 +38,5 @@ Example:
> >  			      "pwm3", "pwm4", "pwm5";
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pwm0_pins>;
> > +		mediatek,num-pwms = <5>;
> >  	};
> > 
> 
> Wasn't there a comment in the last version to use num-pwms instead of
> mediatek,num-pwms?
> 
> Uwe I think you requested that.

Perhaps, but why is this needed? Typically, this would be implied by the 
compatible or the driver doesn't care and we assume 'pwms' properties 
are not out of range.

Rob
