From: Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Date: Mon, 23 Sep 2019 11:20:57 +0800
Message-ID: <1569208857.4102.9.camel@mtksdccf07>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
         <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
         <20190921002149.GB86019@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921002149.GB86019@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Sat, 2019-09-21 at 02:21 +0200, Thierry Reding wrote:
> On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> > From: Ryder Lee <ryder.lee@mediatek.com>
> > 
> > This adds a property "num-pwms" in example so that we could
> > specify the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v6:
> > Follow reviewers's comments:
> > - The subject should indicate this is for Mediatek
> > 
> > Changes since v5:
> > - Add an Acked-by tag
> > - This file is original v4 patch 5/10
> > (https://patchwork.kernel.org/patch/11102577/)
> > 
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> You failed to address Rob's questions repeatedly and I agree with him
> that you can just as easily derive the number of PWMs from the specific
> compatible string. I won't be applying this and none of the patches that
> depend on it.
> 

Hi, 

Thanks for getting back to me.

New pwm driver (patch 04/11 : "pwm: mediatek: allocate the clks array
dynamically") can support different variants with different number of
PWMs by the new property <num-pwms>

For example:
1. Use "num-pwms" = <2> and assign clocks pwm1, pwm2 for mt7622
2. Use "num-pwms" = <6> and assign clocks pwm1, pwm2, pwm3, pwm4, pwm5,
pwm6 for mt7622.

If we just as easily derive the number of PWMs from the specific
compatible string in this document:

   - "pwm1-6": the six per PWM clocks for mt7622
   
This looks like all "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6" is
required property in DT, It doesn't make sense.
   
So we removed those descriptions and added  

   - "pwm1-N": the PWM clocks for each channel 
   
   
But the max number of clocks from the compatible string are still
important information that should be provide in this document.


What do you think of this?

   - "pwm1-N": per PWM clocks for mt2712, the max number of PWM channels
is 8

   - "pwm1-N": per PWM clocks for mt7622, the max number of PWM channels
is 6

   - "pwm1-N": per PWM clocks for mt7623, the max number of PWM channels
is 5

   where N starting from 1 to the maximum number of PWM channels
   - num-pwms: the number of PWM channels.

   
Thanks
Best Regards
Sam 
