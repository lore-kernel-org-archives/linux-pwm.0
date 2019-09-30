From: Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v10 08/12] pwm: mediatek: Add MT7629 compatible string
Date: Mon, 30 Sep 2019 17:51:19 +0800
Message-ID: <1569837079.32131.5.camel@mtksdccf07>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
         <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
         <20190927112831.GA1171568@ulmo> <1569833468.32131.4.camel@mtksdccf07>
         <20190930093629.GH1518582@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930093629.GH1518582@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2019-09-30 at 11:36 +0200, Thierry Reding wrote:
> On Mon, Sep 30, 2019 at 04:51:08PM +0800, Sam Shih wrote:
> > Hi,
> > 
> > On Fri, 2019-09-27 at 13:28 +0200, Thierry Reding wrote:
> > > On Wed, Sep 25, 2019 at 10:32:33PM +0800, Sam Shih wrote:
> > > > This adds pwm support for MT7629, and separate mt7629 compatible string
> > > > from mt7622
> > > > 
> > > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > > ---
> > > >  drivers/pwm/pwm-mediatek.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > 
> > > I picked this patch up and made some minor adjustments to make it build
> > > without the num_pwms patches. With that I don't think there's anything
> > > left from this series that you need.
> > 
> > Yes, I think the driver should work once dtsi updated.
> > ("[v10,12/12] arm: dts: mediatek: add mt7629 pwm support")
> > 
> > But, due to we use comaptible string separately for every SoC now,
> > The comaptible string in dt-bindings should be "mediatek,mt7629-pwm".
> > I think we should use "[v10,11/12] dt-bindings: pwm: update bindings 
> > for MT7629" to replace commit 1c00ad6ebf36aa3b0fa598a48b8ae59782be4121,
> > Or maybe we need a little modification like this ?
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt ...
> > - - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
> > + - "mediatek,mt7629-pwm": found on mt7629 SoC.
> 
> Good catch, I must've taken this from the wrong version of the patch.
> 
> How about the attached patch?
> 
> Thanks,
> Thierry
> --- >8 ---
> From 641b0ee176b139f9edd137ba636ca0cb9c63289a Mon Sep 17 00:00:00 2001
> From: Thierry Reding <thierry.reding@gmail.com>
> Date: Mon, 30 Sep 2019 11:33:31 +0200
> Subject: [PATCH] dt-bindings: pwm: mediatek: Remove gratuitous compatible
>  string for MT7629
> 
> The MT7629 is, in fact, not compatible with the MT7622 because the
> former has a single PWM channel while the former has 6. Remove the
> gratuitous compatible string for MT7629.
> 
> Reported-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index c8501530173c..053e9b5880f1 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -6,7 +6,7 @@ Required properties:
>     - "mediatek,mt7622-pwm": found on mt7622 SoC.
>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> -   - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
> +   - "mediatek,mt7629-pwm": found on mt7629 SoC.
>     - "mediatek,mt8516-pwm": found on mt8516 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of

It seems good to me.

Thanks,
Regards, Sam
