From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
Date: Mon, 11 Jul 2016 09:53:12 -0700
Message-ID: <CAD=FV=WoUi4kNHW1h6XCezJyYUXbWLXj3yPYg+W-qhMAjpPn4A@mail.gmail.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
 <20160708154302.GC1151@ulmo.ba.sec> <20160709094718.GB6247@sirena.org.uk> <20160711070251.GA5823@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160711070251.GA5823@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm <linux-pwm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Milo Kim <milo.kim@ti.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, Jul 11, 2016 at 12:02 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Sat, Jul 09, 2016 at 11:47:18AM +0200, Mark Brown wrote:
>> On Fri, Jul 08, 2016 at 05:43:02PM +0200, Thierry Reding wrote:
>>
>> > Mark, do you want me to provide a stable branch with the PWM regulator
>> > patches and resolve that conflict in your tree? Or would you rather take
>> > the whole set based on a stable branch from the PWM tree? Or maybe yet
>> > another possibility would be to base the PWM tree on a stable branch
>> > from the regulator tree containing the above commit.
>>
>> Probably easiest to use this signed tag and resolve it in your tree:
>>
>> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>>
>>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/pwm-modernization
>>
>> for you to fetch changes up to c2588393e6315ab68207323d37d2a73713d6bc81:
>>
>>   regulator: pwm: Fix regulator ramp delay for continuous mode (2016-07-07 11:45:06 +0200)
>>
>> ----------------------------------------------------------------
>> regulator: Provide a branch for moderninzation of the PWM code
>>
>> There's a new, improved PWM API which allows a lot of improvements in
>> the PWM regulator driver.  Since the bulk of the changes are in the PWM
>> API this is being managed in the PWM tree, merge pending regulator API
>> changes to allow this to be resolved more easily.
>>
>> ----------------------------------------------------------------
>> Alexandre Courbot (1):
>>       regulator: pwm: Support for enable GPIO
>>
>> Boris Brezillon (1):
>>       regulator: pwm: Drop unneeded pwm_enable() call
>>
>> Douglas Anderson (1):
>>       regulator: pwm: Fix regulator ramp delay for continuous mode
>>
>>  .../bindings/regulator/pwm-regulator.txt           |  7 +++-
>>  drivers/regulator/pwm-regulator.c                  | 40 ++++++++++++++++++----
>>  2 files changed, 39 insertions(+), 8 deletions(-)
>
> Merged into for-4.8/regulator of the PWM tree and rebased Boris'
> pwm-regulator patches on top.
>
> Boris, everything looks right to me, but can you take a quick look to
> see if it all matches up with what you expect?

As I mentioned in the other thread about the linuxnext conflict,
pwm_regulator_set_voltage() is wrong.

You have:

  ramp_delay = DIV_ROUND_UP(abs(min_uV - old_uV), ramp_delay);

You should have:

  ramp_delay = DIV_ROUND_UP(abs(req_min_uV - old_uV), ramp_delay);

-Doug
