Return-Path: <zhi.mao@mediatek.com>
Message-ID: <1498111776.18841.10.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND 4/4] pwm: mediatek: add MT2712/MT7622 support
From: Zhi Mao <zhi.mao@mediatek.com>
Date: Thu, 22 Jun 2017 14:09:36 +0800
In-Reply-To: <4600cf23-5e59-df02-37dc-056cb4a9744c@phrozen.org>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
	 <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
	 <4600cf23-5e59-df02-37dc-056cb4a9744c@phrozen.org>
Content-Type: multipart/alternative; boundary="=-XDuRqSonNTredkI0j06t"
MIME-Version: 1.0
Return-Path: zhi.mao@mediatek.com
List-ID: <linux-pwm.vger.kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Zhenbao Liu =?UTF-8?Q?=28=E5=88=98=E6=8C=AF=E5=AE=9D=29?= <Zhenbao.Liu@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= <sean.wang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= <Yt.Shen@mediatek.com>, Yingjoe Chen =?UTF-8?Q?=28=3F=3F=E8=8B=B1=E6=B4=B2=29?= <Yingjoe.Chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--=-XDuRqSonNTredkI0j06t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi John,

Thanks for your review the code and feedback.
There are 3 issues in this patch:
1.adds PWM_CLK_DIV_MAX which really should go into its own patch
2.adds mtk_pwm_com_reg which should also go into its own patch
3.remove comments inline /*===*/

for #1 and #3, I will modify them in the next release.
but for #2, I want to discuss with you, 
adding the structure  "mtk_pwm_com_reg" is only for the registers of
MT2712 PWM8, 
so we want to keep this modification in this patch.

what's your opinion about it? 
Any reply is welcome.


Regards
Zhi





On Wed, 2017-06-21 at 20:22 +0800, John Crispin wrote:

> 
> On 21/06/17 10:11, Zhi Mao wrote:
> > support multiple chip(MT2712, MT7622, MT7623)
> This patch does more than add extra SoC support. It also
> * adds PWM_CLK_DIV_MAX which really should go into its own patch
> * adds mtk_pwm_com_reg which should also go into its own patch
> 
> more comments inline
> 
> >
> > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > ---
> >   drivers/pwm/pwm-mediatek.c |   63 +++++++++++++++++++++++++++++++++++---------
> >   1 file changed, 51 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index c803ff6..d520356 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/module.h>
> >   #include <linux/clk.h>
> >   #include <linux/of.h>
> > +#include <linux/of_device.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pwm.h>
> >   #include <linux/slab.h>
> [...]
> > @@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
> >   	return pwmchip_remove(&pc->chip);
> >   }
> >   
> > +/*==========================================*/
> 
> please remove these comment lines
> 
>      John
> > +static const struct mtk_com_pwm_data mt2712_pwm_data = {
> > +	.pwm_nums = 8,
> > +};
> > +
> > +static const struct mtk_com_pwm_data mt7622_pwm_data = {
> > +	.pwm_nums = 6,
> > +};
> > +
> > +static const struct mtk_com_pwm_data mt7623_pwm_data = {
> > +	.pwm_nums = 5,
> > +};
> > +/*==========================================*/
> > +
> >   static const struct of_device_id mtk_pwm_of_match[] = {
> > -	{ .compatible = "mediatek,mt7623-pwm" },
> > -	{ }
> > +	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
> > +	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
> > +	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
> > +	{},
> >   };
> >   MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
> >   
> 



--=-XDuRqSonNTredkI0j06t
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/4.2.2">
</HEAD>
<BODY>
Hi John,<BR>
<BR>
Thanks for your review the code and feedback.<BR>
There are 3 issues in this patch:<BR>
1.adds PWM_CLK_DIV_MAX which really should go into its own patch<BR>
2.adds mtk_pwm_com_reg which should also go into its own patch<BR>
3.remove comments inline /*===*/<BR>
<BR>
for #1 and #3, I will modify them in the next release.<BR>
but for #2, I want to discuss with you, <BR>
adding the structure&nbsp; &quot;mtk_pwm_com_reg&quot; is only for the registers of MT2712 PWM8, <BR>
so we want to keep this modification in this patch.<BR>
<BR>
what's your opinion about it? <BR>
Any reply is welcome.<BR>
<BR>
<BR>
Regards<BR>
Zhi<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
On Wed, 2017-06-21 at 20:22 +0800, John Crispin wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>

On 21/06/17 10:11, Zhi Mao wrote:
&gt; support multiple chip(MT2712, MT7622, MT7623)
This patch does more than add extra SoC support. It also
* adds PWM_CLK_DIV_MAX which really should go into its own patch
* adds mtk_pwm_com_reg which should also go into its own patch

more comments inline

&gt;
&gt; Signed-off-by: Zhi Mao &lt;<A HREF="mailto:zhi.mao@mediatek.com">zhi.mao@mediatek.com</A>&gt;
&gt; ---
&gt;   drivers/pwm/pwm-mediatek.c |   63 +++++++++++++++++++++++++++++++++++---------
&gt;   1 file changed, 51 insertions(+), 12 deletions(-)
&gt;
&gt; diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
&gt; index c803ff6..d520356 100644
&gt; --- a/drivers/pwm/pwm-mediatek.c
&gt; +++ b/drivers/pwm/pwm-mediatek.c
&gt; @@ -16,6 +16,7 @@
&gt;   #include &lt;linux/module.h&gt;
&gt;   #include &lt;linux/clk.h&gt;
&gt;   #include &lt;linux/of.h&gt;
&gt; +#include &lt;linux/of_device.h&gt;
&gt;   #include &lt;linux/platform_device.h&gt;
&gt;   #include &lt;linux/pwm.h&gt;
&gt;   #include &lt;linux/slab.h&gt;
[...]
&gt; @@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
&gt;   	return pwmchip_remove(&amp;pc-&gt;chip);
&gt;   }
&gt;   
&gt; +/*==========================================*/

please remove these comment lines

     John
&gt; +static const struct mtk_com_pwm_data mt2712_pwm_data = {
&gt; +	.pwm_nums = 8,
&gt; +};
&gt; +
&gt; +static const struct mtk_com_pwm_data mt7622_pwm_data = {
&gt; +	.pwm_nums = 6,
&gt; +};
&gt; +
&gt; +static const struct mtk_com_pwm_data mt7623_pwm_data = {
&gt; +	.pwm_nums = 5,
&gt; +};
&gt; +/*==========================================*/
&gt; +
&gt;   static const struct of_device_id mtk_pwm_of_match[] = {
&gt; -	{ .compatible = &quot;mediatek,mt7623-pwm&quot; },
&gt; -	{ }
&gt; +	{.compatible = &quot;mediatek,mt2712-pwm&quot;, .data = &amp;mt2712_pwm_data},
&gt; +	{.compatible = &quot;mediatek,mt7622-pwm&quot;, .data = &amp;mt7622_pwm_data},
&gt; +	{.compatible = &quot;mediatek,mt7623-pwm&quot;, .data = &amp;mt7623_pwm_data},
&gt; +	{},
&gt;   };
&gt;   MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
&gt;   

</PRE>
</BLOCKQUOTE>
<BR>
</BODY>
</HTML>

--=-XDuRqSonNTredkI0j06t--
