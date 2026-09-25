Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022724AB3CD;
	Fri, 25 Sep 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346833; cv=none; b=URb4IIyDQVtiNETfweR/7C5rDcGDAg7hjZI9nw0Wus/BNmFTuyKjhGmQOmjvo6GAg+4f+gambIibQC4tBimSJy+hchmcd7NpAYW5jrVCzuszLm3j5QFMOBmT+wk02lrFhRIEoCJUKGRT87/Rk7S879vY4VmnUu0Jp2NZmoOBc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346833; c=relaxed/simple;
	bh=9jqyIRV/pOYj50TCwmyP6yS9VVMyAsAlhPgldRTFX2k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sUPrQdDK/4Tzh6VFk6ZMHMd8ZJXyP++QYnd+4gKNEf78iqXHU31atHVa6OO4To6Fe0cZxjmIuHUif0NKmMfoZcgPfwbrEdyXRnzK4tkWR/Zt6d69UM64qTY8+Us2ZvHt0SfYf6KTeEUmp+68ToRCLgeutk23drw3bFwADluuv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=D8kZzq91; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="D8kZzq91"
Message-ID: <ab7ddd32-47eb-47d1-b317-94ee190362a3@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1790346812;
	bh=9jqyIRV/pOYj50TCwmyP6yS9VVMyAsAlhPgldRTFX2k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=D8kZzq91ojMHy1q3+FkGTAj2eKm1J5aSPaflO0zmCg8BH1ETab4I0pA1MHP/6hknr
	 w8df/Xgj5owDwM7Bt0wQUyuhFiRb7Ey7YCUsfm9h98W92rQHetD2TSOdhxK+4pH9oM
	 PXN3yM78+mOOZe5WoU6qFy2gJzsNYQP0iVk6nSaM=
Date: Fri, 25 Sep 2026 16:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
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
References: <20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr>
 <20260924-add-t7-sys-pwm-clk-v1-1-05b91e87f0a9@aliel.fr>
 <20260924-reprimand-taste-3481319d9e31@spud>
Content-Language: en-US
In-Reply-To: <20260924-reprimand-taste-3481319d9e31@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 6:35 PM, Conor Dooley wrote:
> On Thu, Sep 24, 2026 at 05:14:28PM +0200, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> The T7 PWM controller has a system clock (the register access clock)
>> in addition to the two input clocks of channels A and B. Add it as a
>> third clock, named "core", for the amlogic,t7-pwm compatible, and
>> require clock-names for this SoC for clarity.
> 
> What additional clarity does that actually bring? I think it's kinda
> less clear, because the git history is required to explain why drivers
> cannot fetch the existing clocks by name.
> 

Right it's not clear, I will rephrase this.

>>
>> The other compatibles are left unchanged. Add an example showing the
>> T7 usage with its fallback to amlogic,meson-s4-pwm.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 37 +++++++++++++++++++---
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index c337d85da40f1..9212a40d9fe48 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -62,7 +62,7 @@ properties:
>>  
>>    clock-names:
>>      minItems: 1
>> -    maxItems: 2
>> +    maxItems: 3
>>  
>>    power-domains:
>>      maxItems: 1
>> @@ -135,17 +135,38 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            enum:
>> -              - amlogic,meson-s4-pwm
>> +            const: amlogic,t7-pwm
>>      then:
>>        properties:
>>          clocks:
>>            items:
>>              - description: input clock of PWM channel A
>>              - description: input clock of PWM channel B
>> -        clock-names: false
>> +            - description: gate clock for the PWM controller
>> +        clock-names:
>> +          items:
>> +            - const: clk_a
>> +            - const: clk_b
> 
> I'd rather "channel-a" or similar, we try not to state the obvious in
> the names of clocks etc - of course this is a clock!
> 

Thanks for the suggestion, I didn't want to add "clk_chan_a", I will go
with "channel-a" and "channel-b".

>> +            - const: core
>>        required:
>>          - clocks
>> +        - clock-names
>> +    else:
>> +      if:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              enum:
>> +                - amlogic,meson-s4-pwm
>> +      then:
>> +        properties:
>> +          clocks:
>> +            items:
>> +              - description: input clock of PWM channel A
>> +              - description: input clock of PWM channel B
>> +          clock-names: false
> 
> Are you sure that the s4-pwm doesn't also have this core clock? Seems
> likely, no?
> 

You right, S4, A1, C3 and T7 have this clock, but S4 and A1 clock driver
declare them with "CLK_IGNORE_UNUSED" flag.
I will make a new proposal on V2.

> Cheers,
> Conor.
> 
>> +        required:
>> +          - clocks
>>  
>>    - if:
>>        properties:
>> @@ -182,3 +203,11 @@ examples:
>>        clocks = <&pwm_src_a>, <&pwm_src_b>;
>>        #pwm-cells = <3>;
>>      };
>> +  - |
>> +    pwm@60000 {
>> +      compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
>> +      reg = <0x60000 0x24>;
>> +      clocks = <&clk_a>, <&clk_b>, <&core>;
>> +      clock-names = "clk_a", "clk_b", "core";
>> +      #pwm-cells = <3>;
>> +    };
>>
>> -- 
>> 2.49.0
>>
>>


-- 
Best regards,
Ronald
