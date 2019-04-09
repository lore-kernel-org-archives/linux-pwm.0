From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 02/18] counter: Documentation: Add Generic Counter
 sysfs documentation
Date: Tue, 9 Apr 2019 14:07:08 +0900
Message-ID: <20190409050708.GB2842@icarus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215531.GB27592@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408215531.GB27592@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 08, 2019 at 11:55:31PM +0200, Pavel Machek wrote:
> On Tue 2019-04-02 15:30:37, William Breathitt Gray wrote:
> > This patch adds standard documentation for the userspace sysfs
> > attributes of the Generic Counter interface.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
> >  MAINTAINERS                                 |   1 +
> >  2 files changed, 231 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> > new file mode 100644
> > index 000000000000..566bd99fe0a5
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -0,0 +1,230 @@
> > +What:		/sys/bus/counter/devices/counterX/countY/count
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count data of Count Y represented as a string.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/ceiling
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count value ceiling for Count Y. This is the upper limit for the
> > +		respective counter.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/floor
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count value floor for Count Y. This is the lower limit for the
> > +		respective counter.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/count_mode
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count mode for channel Y. The ceiling and floor values for
> > +		Count Y are used by the count mode where required. The following
> > +		count modes are available:
> > +
> > +		normal:
> > +			Counting is continuous in either direction.
> > +
> > +		range limit:
> > +			An upper or lower limit is set, mimicking limit switches
> > +			in the mechanical counterpart. The upper limit is set to
> > +			the Count Y ceiling value, while the lower limit is set
> > +			to the Count Y floor value. The counter freezes at
> > +			count = ceiling when counting up, and at count = floor
> > +			when counting down. At either of these limits, the
> > +			counting is resumed only when the count direction is
> > +			reversed.
> > +
> > +		non-recycle:
> > +			The counter is disabled whenever a counter overflow or
> > +			underflow takes place. The counter is re-enabled when a
> > +			new count value is loaded to the counter via a preset
> > +			operation or direct write.
> > +
> > +		modulo-n:
> > +			A count value boundary is set between the Count Y floor
> > +			value and the Count Y ceiling value. The counter is
> > +			reset to the Count Y floor value at count = ceiling when
> > +			counting up, while the counter is set to the Count Y
> > +			ceiling value at count = floor when counting down; the
> > +			counter does not freeze at the boundary points, but
> > +			counts continuously throughout.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
> > +What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
> > +What:		/sys/bus/counter/devices/counterX/countY/function_available
> > +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Discrete set of available values for the respective Count Y
> > +		configuration are listed in this file. Values are delimited by
> > +		newline characters.
> 
> Elsewhere in sysfs we do space-separated:
> 
> pavel@amd:~$ cat /sys/power/state
> freeze mem disk
> 
> And we use [] to mark current selection:
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
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Marking the current selection with [] or similar does seem useful. But
delimiting by space does seem to cause confusion in cases where the
values also include spaces (e.g. "quadrature x1 a"). I see that in these
cases a "-" is used in place of a space, but that wouldn't work very
well when values can also contain hyphens (e.g. "pulse-direction").

William Breathitt Gray
