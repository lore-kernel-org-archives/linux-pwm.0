Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B021A42D;
	Sun, 27 Sep 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519670; cv=none; b=eeA9mrmnVqtfAOzll5CrhDBrgRW29hKlYak7rUKYO2rM8YlXoYfzaaSP9cwxeGXYkY06bKCsXSkKT5l5fQ9DSTP7FjWWG5QEJgdOr6eVDv8SmG0eCwLVizVRxTjoHilFE1uf+O1CJ1BIoCYe997UzixYkn6AI/ar80EN9b0q41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519670; c=relaxed/simple;
	bh=ztJhP76JayIyO0vestWNJjdUJp+q5q9ZNKkeqnfojU0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sa2fSokMmm+RYg9SFicWxXGhMzY6YlahZO2+gTwHWyfOJjHG1Il6a6Ob+GGHvfgkIhAt4WcQ/shkxsZTD7/M3i8IKE95Tiog0wij6yD4dKhPEIpDvNh48tYDxiNd7aTnfd8qOGoCXjEXmLYms7braL+jBEplv48w/I4CodXojgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=TRXtbZOB; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="TRXtbZOB"
Message-ID: <80268113-e85f-410d-880d-84598d3b39ca@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1790519659;
	bh=ztJhP76JayIyO0vestWNJjdUJp+q5q9ZNKkeqnfojU0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TRXtbZOBVpquhw7aODGwXsianL++tf49/r+mxiGRB52OrT7mzX3oCYHo3lGvJc0yE
	 CACasfZmg9DjFEWdXlSk7o3LoQpM3oeILuMZwzyLCo368JV2ulEp8NFXwpmPG61WYQ
	 n0mdxnWO8uJLB+//9dIdHpSfMjZVq8N1ISvz1FgE=
Date: Sun, 27 Sep 2026 16:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr>
 <20260925-add-t7-sys-pwm-clk-v2-1-f23a22b71a5c@aliel.fr>
 <20260925-facial-follow-032de22361c1@spud>
 <8e23838a-da5e-499c-a8be-3e2a7a0939e7@aliel.fr>
 <20260926-landless-prowess-df404db4d910@spud>
Content-Language: en-US
In-Reply-To: <20260926-landless-prowess-df404db4d910@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/26 8:06 PM, Conor Dooley wrote:
> On Sat, Sep 26, 2026 at 11:43:20AM +0200, linux-kernel-dev@aliel.fr wrote:
>> On 9/25/26 6:41 PM, Conor Dooley wrote:
>>> On Fri, Sep 25, 2026 at 05:13:28PM +0200, Ronald Claveau via B4 Relay wrote:
>>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>>>
>>>> The T7, A1, C3, and S4 PWM controllers have a system clock in
>>>> addition to the two input clocks of channels A and B.
>>>>
>>>> The channel clocks are acquired by index in the pwm driver,
>>>> where the core clock is fetched by name, with optional get
>>>> which is silent when not provided.
>>>>
>>>> Require clock-names and minimum 3 items for T7, where the
>>>> PWM devices do not work without all 3 clocks.
>>>>
>>>> Add an example showing T7 usage with its fallback to
>>>> amlogic,meson-s4-pwm.
>>>>
>>>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>>> ---
>>>>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 33 ++++++++++++++++++++--
>>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> index c337d85da40f1..59320f288552b 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> @@ -62,7 +62,7 @@ properties:
>>>>  
>>>>    clock-names:
>>>>      minItems: 1
>>>> -    maxItems: 2
>>>> +    maxItems: 3
>>>>  
>>>>    power-domains:
>>>>      maxItems: 1
>>>> @@ -140,13 +140,34 @@ allOf:
>>>>      then:
>>>>        properties:
>>>>          clocks:
>>>> +          minItems: 2
>>>>            items:
>>>>              - description: input clock of PWM channel A
>>>>              - description: input clock of PWM channel B
>>>> -        clock-names: false
>>>> +            - description: gate clock for the PWM controller
>>>> +        clock-names:
>>>> +          minItems: 2
>>>> +          items:
>>>> +            - const: channel-a
>>>> +            - const: channel-b
>>>> +            - const: core
>>>>        required:
>>>>          - clocks
>>>>  
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: amlogic,t7-pwm
>>>
>>> Shouldn't this (based on your reply on the previous version) be s4?
>>>
>>
>> The change above is for S4 and SOCs which fallback to S4. It allows the
>> third clock but let the schema validation compatible with two clocks
>> existing DTS. Here for the T7, I add requirement for the exact 3 clocks.
>>
>> Do you recommend to require the 3 clocks for all S4 and S4 fallback, and
>> update the associated dtsi files ?
> 
> Yes, I think so. Sounds to me like they only work because of the
> CLK_IGNORE_UNUSED set in their clock controller drivers, so the correct
> thing to do is make them all require the third clock.
> 

Great, Thank you for your feedback, I sent a V3 matching this.

>>
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 3
>>>> +        clock-names:
>>>> +          minItems: 3
>>>> +      required:
>>>> +        - clock-names
>>>> +
>>>>    - if:
>>>>        properties:
>>>>          compatible:
>>>> @@ -182,3 +203,11 @@ examples:
>>>>        clocks = <&pwm_src_a>, <&pwm_src_b>;
>>>>        #pwm-cells = <3>;
>>>>      };
>>>> +  - |
>>>> +    pwm@60000 {
>>>> +      compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
>>>> +      reg = <0x60000 0x24>;
>>>> +      clocks = <&channel_a>, <&channel_b>, <&core>;
>>>> +      clock-names = "channel-a", "channel-b", "core";
>>>> +      #pwm-cells = <3>;
>>>> +    };
>>>>
>>>> -- 
>>>> 2.49.0
>>>>
>>>>
>>
>>
>> -- 
>> Best regards,
>> Ronald


-- 
Best regards,
Ronald
