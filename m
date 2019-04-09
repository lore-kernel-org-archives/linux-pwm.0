From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v10 02/18] counter: Documentation: Add Generic Counter
 sysfs documentation
Date: Tue, 9 Apr 2019 08:12:57 -0500
Message-ID: <d7a44b77-a8e5-d4fa-9a11-96cdde862b4c@lechnology.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215531.GB27592@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408215531.GB27592@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-pwm@vger.kernel.org

On 4/8/19 4:55 PM, Pavel Machek wrote:
> 
> pavel@amd:~$ cat /sys/power/state
> freeze mem disk
> 
> And we use [] to mark current selection:

I know this is used elsewhere, but I don't think it is a good pattern
to copy. Parsing it from user-space is annoying. Also it breaks the
sysfs rule of "one item per file" since it tells us two things - the
list of possible values _and_ the current active value.

> 
> pavel@amd:~$ cat /sys/class/leds/tpacpi\:\:thinkvantage/trigger
> [none] bluetooth-power rfkill-any rfkill-none kbd-scrolllock
> kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock
> kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock
> kbd-ctrlrlock AC-online BAT0-charging-or-full BAT0-charging BAT0-full
> BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
> phy0radio phy0tpt mmc0 timer heartbeat audio-mute audio-micmute
> rfkill1
> 
> Note this only works if you have less than PAGE_SIZE of entries... and
> will never have more.
> 
> 									Pavel
> 
