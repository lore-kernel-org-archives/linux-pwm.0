From: =?UTF-8?B?0JLQvtC70LrQvtCyINCh0LXRgNCz0LXQuQ==?= <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: pwm: sun4i: unification of
 register operations for support sun6i.
Date: Wed, 8 Feb 2017 19:41:55 +0300
Message-ID: <CAKNVLfaYoPf-b-mGc0eSmmAk0QPhMCRt5aT5Z3JBcfKhridWDA@mail.gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-2-git-send-email-lis8215@gmail.com> <20170208075219.oo234d5zartzmzsg@lukather>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a114d88bc00cb4a0548078be9
Return-path: <linux-sunxi+bncBDJLROMN3MJRBVMU5XCAKGQE4FOX33Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170208075219.oo234d5zartzmzsg@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

--001a114d88bc00cb4a0548078be9
Content-Type: text/plain; charset=UTF-8

Hello all,

>> This patch not introduce new features, just prepare code for
>> adding sun6i PWM driver in next commits.
>>
>> A31 SoC have a different map of PWM registers than others ASoCs,
>> but register bits purposes are very similar.
>>
>> This patch introduce set of register access routines, which
>> are common for existing in driver ASoCs:
>>  - ctl_rdy   - checks the ready bit of specified PWM channel,
>>  - ctl_read  - reads value from control register of specified PWM
channel,
>>  - ctl_write - writes significant bits to control register of specified
PWM channel,
>>  - prd_read  - reads value from period register of specified PWM channel,
>>  - prd_write - writes value to period register of specified PWM channel.
>> Driver code redesigned to use the new routines.
>
> Why don't you use regmap for that?

First of all, i'm newbie and its my first patchset. I just remake what i
see in the driver. I even don't suspect about use regmap here.

Second thing - i can't test these driver on all existing sunxi SoCs, i have
only A31 and A20 based boards where only pwm0 is accessible. Huge redesign
cause bigger chance to make a mistake.

If you think regmap solution is a must, then i will do that. This will be a
good experience for me.

Thanks,
Siarhei

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--001a114d88bc00cb4a0548078be9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div><div>&gt;&gt; This patch not=
 introduce new features, just prepare code for</div><div>&gt;&gt; adding su=
n6i PWM driver in next commits.</div><div>&gt;&gt;</div><div>&gt;&gt; A31 S=
oC have a different map of PWM registers than others ASoCs,</div><div>&gt;&=
gt; but register bits purposes are very similar.</div><div>&gt;&gt;</div><d=
iv>&gt;&gt; This patch introduce set of register access routines, which</di=
v><div>&gt;&gt; are common for existing in driver ASoCs:</div><div>&gt;&gt;=
 =C2=A0- ctl_rdy =C2=A0 - checks the ready bit of specified PWM channel,</d=
iv><div>&gt;&gt; =C2=A0- ctl_read =C2=A0- reads value from control register=
 of specified PWM channel,</div><div>&gt;&gt; =C2=A0- ctl_write - writes si=
gnificant bits to control register of specified PWM channel,</div><div>&gt;=
&gt; =C2=A0- prd_read =C2=A0- reads value from period register of specified=
 PWM channel,</div><div>&gt;&gt; =C2=A0- prd_write - writes value to period=
 register of specified PWM channel.</div><div>&gt;&gt; Driver code redesign=
ed to use the new routines.</div><div>&gt;</div><div>&gt; Why don&#39;t you=
 use regmap for that?</div><div><br></div><div>First of all, i&#39;m newbie=
 and its my first patchset. I just remake what i see in the driver. I even =
don&#39;t suspect about use regmap here.</div><div><br></div><div>Second th=
ing - i can&#39;t test these driver on all existing sunxi SoCs, i have only=
 A31 and A20 based boards where only pwm0 is accessible. Huge redesign caus=
e bigger chance to make a mistake.</div><div><br></div><div>If you think re=
gmap solution is a must, then i will do that. This will be a good experienc=
e for me.</div><div><br></div><div>Thanks,</div><div>Siarhei</div></div></d=
iv>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a114d88bc00cb4a0548078be9--
