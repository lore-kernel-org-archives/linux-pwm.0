Return-Path: <sylvester.nawrocki@gmail.com>
Return-Path: <sylvester.nawrocki@gmail.com>
Message-ID: <51B909A5.2020409@gmail.com>
Date: Thu, 13 Jun 2013 01:52:05 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/15] Final Samsung PWM support cleanup
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <20130612230023.GA9016@quad.lixom.net> <1604160.oAKkaEhla1@flatron> <201306130138.05692.heiko@sntech.de>
In-Reply-To: <201306130138.05692.heiko@sntech.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On 06/13/2013 01:38 AM, Heiko St=EF=BF=BDbner wrote:
> Am Donnerstag, 13. Juni 2013, 01:13:47 schrieb Tomasz Figa:
>> Hi Olof,
>>
>> On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
>>> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
>>>>> Needs testing on other platforms as I could only compile test for
>>>>> them.
>>>
>>> How/who can help here? WHo has and still cares for other affected
>>> platforms?
>>>
>>>>> 66 files changed, 627 insertions(+), 1580 deletions(-)
>>
>> I will try to test this on Exynos 4 at work, if I somehow manage to find
>> any way to use PWM on our boards (other than already-tested PWM
>> clocksource).
>>
>> Unfortunately, except S3C6410, I don't have access to other platforms, or
>> at least I won't in any reasonable time.
>>
>> If I remember correctly, in case of my watchdog support cleanup, Kukjin
>> has been able to test it on S5P64x0.
>>
>> Heiko and Sylwester used to have some s3c24xx-based boards, not sure if
>> they still do and are interested in their support in mainline.
>>
>> So all left is S5PC100 (for which I couldn't find anyone who cares) and
>> Exynos5.
>>
>>> Nice cleanup.
>>
>> Thanks.
>>
>>>> Any comments for this series?
>>>
>>> Yes, above. :) In general looks good -- testing coverage is a bit of a
>>> concern.
>>
>> Yeah. Unfortunately all I could do was testing on Tiny6410 and compile
>> testing on others. I hope we find some really helpful people over here w=
ho
>> could waste a bit of their precious time for this museum. ;)
>
> I'll try to give it a testrun tomorrow. And my s3c2416 will always be the
> first-love-architecture for me ;-)

I'll likely test it tomorrow on a Mini2440 board, I was going to do it=20
earlier
but got distracted by plenty other things that needed attention too. At=20
least
that's one of the reasons I got the board - testing the cross-platform=20
cleanups
and ensuring they are not breaking the older platforms.

Regards,
Sylwester
