From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add MediaTek display PWM bindings
Date: Fri, 3 Jun 2016 17:03:53 +0200
Message-ID: <57519C59.5040107@gmail.com>
References: <1464597712-5399-1-git-send-email-weiqing.kong@mediatek.com>
 <1464597712-5399-2-git-send-email-weiqing.kong@mediatek.com>
 <20160602224550.GA19256@rob-hp-laptop> <1464936349.5209.9.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34292 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbcFCPD5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 11:03:57 -0400
In-Reply-To: <1464936349.5209.9.camel@mhfsdcap03>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: weiqing kong <weiqing.kong@mediatek.com>, Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, erin.lo@mediatek.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, yh.huang@mediatek.com, yt.shen@mediatek.com



On 03/06/16 08:45, weiqing kong wrote:
> On Thu, 2016-06-02 at 17:45 -0500, Rob Herring wrote:
>> On Mon, May 30, 2016 at 04:41:50PM +0800, Weiqing Kong wrote:
>>> Add MT2701 compatible string.
>>>
>>> Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
>>> ---
>>>   Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>> index f8f59ba..f2f2fa9 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>> @@ -1,9 +1,10 @@
>>>   MediaTek display PWM controller
>>>
>>>   Required properties:
>>> - - compatible: should be "mediatek,<name>-disp-pwm":
>>> -   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
>>> + - compatible: should be like these:
>>> +   - "mediatek,mt2701-disp-bls": found on mt2701 SoC.
>>
>> Why bls instead of pwm?
>
> In mt6595/mt8173, we have a hardware module named pwm.
> In mt2701, we have bls hardware module which includes disp pwm function,
> so we named it mt2701-disp-bls rather than mt2701-disp-pwm in order to
> match with hardware spec.
> thanks.
>

 From what I understand pwm module and disp pwm in mt6589/mt8173 is 
independent from the disp pwm. Actually the disp pwm in mt6589 is part 
of the bls module, so this should me mediatek,mt2701-disp-pwm as well

Thanks,
Matthias

>>
>>>      - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
>>> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
>>>    - reg: physical base address and length of the controller's registers.
>>>    - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>>>      the cell format.
>>> --
>>> 1.8.1.1.dirty
>>>
>
>
