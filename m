Return-Path: <ldewangan@nvidia.com>
Message-ID: <58E674FB.3080006@nvidia.com>
Date: Thu, 6 Apr 2017 22:33:55 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2 2/4] pwm: tegra: Increase precision in pwm rate calculation
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com> <1491488461-24621-3-git-send-email-ldewangan@nvidia.com> <20170406162417.GB19312@ulmo.ba.sec>
In-Reply-To: <20170406162417.GB19312@ulmo.ba.sec>
Return-Path: ldewangan@nvidia.com
Content-Type: multipart/alternative;
	boundary="------------090305010106000103050904"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: robh+dt@kernel.org, jonathanh@nvidia.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

--------------090305010106000103050904
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


On Thursday 06 April 2017 09:54 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Apr 06, 2017 at 07:50:59PM +0530, Laxman Dewangan wrote:
>> The rate of the PWM calculated as follows:
>> 	hz = NSEC_PER_SEC / period_ns;
>>   	rate = (rate + (hz / 2)) / hz;
>>
>> This has the precision loss in lower PWM rate.
>> Changing this to have more precision as:
>> 	hz = DIV_ROUND_CLOSE(NSEC_PER_SEC * 100, period_ns);
>> 	rate = DIV_ROUND_CLOSE(rate * 100, hz)
> DIV_ROUND_CLOSEST(). And I much prefer this to the actual code below. I
> don't think it's necessary to have a local variable for the precision.
Do you suggest to use DIV_ROUND_CLOSEST() instead of 
DIV_ROUND_CLOSEST_ULL()?

This is ULL division and so we need to use this one.

Or am I missing something

--------------090305010106000103050904
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">On Thursday 06 April 2017 09:54 PM,
      Thierry Reding wrote:<br>
    </div>
    <blockquote cite="mid:20170406162417.GB19312@ulmo.ba.sec"
      type="cite">
      <pre wrap="">* PGP Signed by an unknown key

On Thu, Apr 06, 2017 at 07:50:59PM +0530, Laxman Dewangan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">The rate of the PWM calculated as follows:
	hz = NSEC_PER_SEC / period_ns;
 	rate = (rate + (hz / 2)) / hz;

This has the precision loss in lower PWM rate.
Changing this to have more precision as:
	hz = DIV_ROUND_CLOSE(NSEC_PER_SEC * 100, period_ns);
	rate = DIV_ROUND_CLOSE(rate * 100, hz)
</pre>
      </blockquote>
      <pre wrap="">
DIV_ROUND_CLOSEST(). And I much prefer this to the actual code below. I
don't think it's necessary to have a local variable for the precision.
</pre>
    </blockquote>
    Do you suggest to use DIV_ROUND_CLOSEST() instead of <font
      face="sans-serif">DIV_ROUND_CLOSEST_ULL</font>()?<br>
    <br>
    This is ULL division and so we need to use this one.<br>
    <br>
    Or am I missing something<br>
  </body>
</html>

--------------090305010106000103050904--
