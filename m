Return-Path: <jk@ozlabs.org>
Date: Sat, 08 Jul 2017 09:46:40 +0800
In-Reply-To: <20170706091743.GP16144@ulmo.fritz.box>
References: <20170608122416.1993-1-jbrunet@baylibre.com> <20170706065910.GJ16144@ulmo.fritz.box> <1499331740.15362.11.camel@baylibre.com> <20170706091743.GP16144@ulmo.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----W3WKRFAMUTMR6856QSMDN7JUB0E3L7"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/3] pwm: add pwm AO on meson gx
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <87BA4FE1-87D8-4C73-8736-090DFD06DF13@ozlabs.org>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

------W3WKRFAMUTMR6856QSMDN7JUB0E3L7
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm just on a short holiday at the moment, but will check this out when I'=
m back home, early next week=2E

Cheers,


Jeremy

On 6 July 2017 5:17:43 pm AWST, Thierry Reding <thierry=2Ereding@gmail=2Ec=
om> wrote:
>On Thu, Jul 06, 2017 at 11:02:20AM +0200, Jerome Brunet wrote:
>> On Thu, 2017-07-06 at 08:59 +0200, Thierry Reding wrote:
>> > On Thu, Jun 08, 2017 at 02:24:13PM +0200, Jerome Brunet wrote:
>> > > The pwms found in the AO domain of the meson gx family have
>different
>> > > clock sources than the ones found in the EE domain=2E The AO pwms
>only
>> > > have 2 connected clock input which are clk81 and the crytal=2E
>> > >=20
>> > > This patchset adds the necessary compatible and the clock data
>for it=2E
>> > >=20
>> > > Changes since v1: [0]
>> > > * Correct clock source order for gxbb pwm ao=2E Documenation shows
>xtal as
>> > > =C2=A0 source #1 while it is actually source #0
>> > > * Add patch 3 to fix pwm calculation=2E Issue while testing pwm
>with clk81
>> > > =C2=A0 as clock source=2E
>> > >=20
>> > >
>[0]:=C2=A0=C2=A0https://lkml=2Ekernel=2Eorg/r/20170607133013=2E4766-1-jbr=
unet@baylibre=2Ecom
>> > >=20
>> > > Jerome Brunet (3):
>> > > =C2=A0 dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
>> > > =C2=A0 pwm: meson: add compatible for the gxbb ao pwms
>> > > =C2=A0 pwm: meson: improve pwm calculation precision=2E
>> > >=20
>> > > =C2=A0=2E=2E=2E/devicetree/bindings/pwm/pwm-meson=2Etxt=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04 +-
>> > > =C2=A0drivers/pwm/pwm-meson=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 47
>+++++++++++++++++
>> > > -----
>> > > =C2=A02 files changed, 41 insertions(+), 10 deletions(-)
>> >=20
>> > For some reason the Author field keeps getting set to:
>> >=20
>> > 	jbrunet <jbrunet@baylibre=2Ecom>
>> >=20
>> > It seems like the headers are correct, so maybe this is patchwork
>> > messing things up?
>>=20
>> And it strikes again =2E=2E=2E :(
>> I already had the issue with https://patchwork=2Ekernel=2Eorg a few mon=
th
>ago=2E
>> I have contacted the kernel=2Eorg helpdesk about it and here is the
>explanation:
>>=20
>> "Patchwork treats users and patch submitters slightly differently, so
>once your
>> entry is created upon first patch submission, it sticks forever=2E I've
>adjusted
>> your entry manually per your request=2E"
>>=20
>> So my very first patch on the ML must have been malformed somehow=2E
>>=20
>> >=20
>> > Anyway, I've applied the series and manually fixed up the Author
>field=2E
>>=20
>> Thanks a lot for this !=20
>> Any idea who I may contact to get this "manual adjustment" done on
>https://patch
>> work=2Eozlabs=2Eorg/ ?
>
>I /think/ Jeremy Kerr (To'ed) would be a good person to contact about
>this=2E
>
>Jeremy, anything you can do about this?
>
>Thanks,
>Thierry

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------W3WKRFAMUTMR6856QSMDN7JUB0E3L7
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Hi all,<br>
<br>
I&#39;m just on a short holiday at the moment, but will check this out whe=
n I&#39;m back home, early next week=2E<br>
<br>
Cheers,<br>
<br>
<br>
Jeremy<br><br><div class=3D"gmail_quote">On 6 July 2017 5:17:43 pm AWST, T=
hierry Reding &lt;thierry=2Ereding@gmail=2Ecom&gt; wrote:<blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px sol=
id rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">On Thu, Jul 06, 2017 at 11:02:20AM +0200, Jerome Bru=
net wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
1ex 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> On Thu, 2=
017-07-06 at 08:59 +0200, Thierry Reding wrote:<br /><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid #a=
d7fa8; padding-left: 1ex;"> On Thu, Jun 08, 2017 at 02:24:13PM +0200, Jerom=
e Brunet wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt=
 0pt 1ex 0=2E8ex; border-left: 1px solid #8ae234; padding-left: 1ex;"> The =
pwms found in the AO domain of the meson gx family have different<br /> clo=
ck sources than the ones found in the EE domain=2E The AO pwms only<br /> h=
ave 2 connected clock input which are clk81 and the crytal=2E<br /> <br /> =
This patchset adds the necessary compatible and the clock data for it=2E<br=
 /> <br /> Changes since v1: [0]<br /> * Correct clock source order for gxb=
b pwm ao=2E Documenation shows xtal as<br /> &nbsp; source #1 while it is a=
ctually source #0<br /> * Add patch 3 to fix pwm calculation=2E Issue while=
 testing pwm with clk81<br /> &nbsp; as clock source=2E<br /> <br /> [0]:&n=
bsp;&nbsp;<a href=3D"https://lkml=2Ekernel=2Eorg/r/20170607133013=2E4766-1-=
jbrunet@baylibre=2Ecom">https://lkml=2Ekernel=2Eorg/r/20170607133013=2E4766=
-1-jbrunet@baylibre=2Ecom</a><br /> <br /> Jerome Brunet (3):<br /> &nbsp; =
dt-bindings: pwm: meson: add comptabible for gxbb ao pwms<br /> &nbsp; pwm:=
 meson: add compatible for the gxbb ao pwms<br /> &nbsp; pwm: meson: improv=
e pwm calculation precision=2E<br /> <br /> &nbsp;=2E=2E=2E/devicetree/bind=
ings/pwm/pwm-meson=2Etxt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;|&nbsp;&nbsp;4 +-<br /> &nbsp;drivers/pwm/pwm-meson=2Ec&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;| 47 +++++++++++++++++<br /> -----<br /> &nbsp;2 files changed, 41 i=
nsertions(+), 10 deletions(-)<br /></blockquote> <br /> For some reason the=
 Author field keeps getting set to:<br /> <br />  jbrunet &lt;jbrunet@bayli=
bre=2Ecom&gt;<br /> <br /> It seems like the headers are correct, so maybe =
this is patchwork<br /> messing things up?<br /></blockquote> <br /> And it=
 strikes again =2E=2E=2E :(<br /> I already had the issue with <a href=3D"h=
ttps://patchwork=2Ekernel=2Eorg">https://patchwork=2Ekernel=2Eorg</a> a few=
 month ago=2E<br /> I have contacted the <a href=3D"http://kernel=2Eorg">ke=
rnel=2Eorg</a> helpdesk about it and here is the explanation:<br /> <br /> =
&quot;Patchwork treats users and patch submitters slightly differently, so =
once your<br /> entry is created upon first patch submission, it sticks for=
ever=2E I've adjusted<br /> your entry manually per your request=2E&quot;<b=
r /> <br /> So my very first patch on the ML must have been malformed someh=
ow=2E<br /> <br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0p=
t 1ex 0=2E8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> <br /> =
Anyway, I've applied the series and manually fixed up the Author field=2E<b=
r /></blockquote> <br /> Thanks a lot for this ! <br /> Any idea who I may =
contact to get this &quot;manual adjustment&quot; done on https://patch<br =
/> <a href=3D"http://work=2Eozlabs=2Eorg">work=2Eozlabs=2Eorg</a>/ ?<br /><=
/blockquote><br />I /think/ Jeremy Kerr (To'ed) would be a good person to c=
ontact about<br />this=2E<br /><br />Jeremy, anything you can do about this=
?<br /><br />Thanks,<br />Thierry<br /></pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E</=
body></html>
------W3WKRFAMUTMR6856QSMDN7JUB0E3L7--
