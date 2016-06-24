From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/5] pwm: tegra: Add DT node compatible for Tegra186
Date: Fri, 24 Jun 2016 15:30:32 -0600
Message-ID: <576DA678.7020907@wwwdotorg.org>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
 <1466596043-27262-5-git-send-email-ldewangan@nvidia.com>
 <20160622124614.GG26943@ulmo.ba.sec> <20160624161015.GA13727@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33730 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbcFXVah (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jun 2016 17:30:37 -0400
In-Reply-To: <20160624161015.GA13727@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, gnurou@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/24/2016 10:10 AM, Rob Herring wrote:
> On Wed, Jun 22, 2016 at 02:46:14PM +0200, Thierry Reding wrote:
>> On Wed, Jun 22, 2016 at 05:17:22PM +0530, Laxman Dewangan wrote:
>>> Tegra186 has 8 different PWM controller and each controller has only
>>> one output. Earlier generation SoCs have the 4 PWM output per controller.
>>>
>>> Add DT node compatible for Tegra186.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>> ---
>>>   Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>>> index c52f03b..2851b2d 100644
>>> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>>> @@ -1,10 +1,12 @@
>>>   Tegra SoC PWFM controller
>>>
>>>   Required properties:
>>> -- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra30,
>>> -  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
>>> -  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
>>> -  tegra124, tegra132, or tegra210.
>>> +- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".
>>> +	      For Tegra30, must contain "nvidia,tegra30-pwm".
>>> +	      For Tegra114, Tegra124, Tegra132, Tegra210 must contain
>>> +	      "nvidia,<chip>-pwm", plus one of the above, where <chip> is
>>> +	      tegra114, tegra124, tegra132, or tegra210.
>>> +	      For Tegra186, must contain "nvidia,tegra186-pwm".
>>
>> Rob, I recall discussing this with you a couple of weeks ago, but fail
>> to remember the outcome and can't find a link to the discussion either.
>> Wasn't there a new standard way of documenting this kind of compatible
>> string list?
>
> We did? This is fine for me. However, "plus one of the above" is not
> clear. That means either is valid? If all are "the same" I would expect
> that only nvidia,tegra20-pwm is the fallback. I'm guessing this is
> docuemnting what happened in practice though. Probably should update the
> doc and dts files to reflect desired practice rather than what may be in
> the wild.

FWIW, I've started listing the legal values as explicit separate bullet 
items rather than prose. See the example below - all those entries are 
just one string simply due to the HW design it represents, but each 
entry could be a list (i.e. is a complete compatible value):

- compatible
     Array of strings.
     One of:
     - "nvidia,tegra186-gpio".
     - "nvidia,tegra186-gpio-aon".

could be expanded as e.g.

     - "nvidia,tegra999-gpio", "nvidia,tegra186-gpio"
     ...
