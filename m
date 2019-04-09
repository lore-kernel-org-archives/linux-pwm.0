From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter
 interface
Date: Tue, 9 Apr 2019 13:57:28 +0900
Message-ID: <20190409045728.GA2842@icarus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215515.GA27592@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408215515.GA27592@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 08, 2019 at 11:55:15PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +const char *const counter_count_direction_str[2] = {
> > +	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
> > +	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> > +
> > +const char *const counter_count_mode_str[4] = {
> > +	[COUNTER_COUNT_MODE_NORMAL] = "normal",
> > +	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
> > +	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
> > +	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_mode_str);
> 
> Dunno. Exporting const tables saying "forward" and "backward". Can we
> ... somehow make it work without need to export this?
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Right now there are only have 4 counter devices supported in this
patchset, but it is expected that support for a greater variety of
devices will be added. For these future cases, new count directions will
be added to match their functionality.

For example, suppose support for a rotary encoder device is added. These
type of devices do not move forward/backward but rather rotate. In these
cases, the following count directions may be added:

    [COUNTER_COUNT_DIRECTION_CLOCKWISE] = "clockwise",
    [COUNTER_COUNT_DIRECTION_COUNTERCLOCKWISE] = "counterclockwise"

Or as another example, suppose support for a two-axis precision
positioning table is added. These devices support positioning in a
cartesian coordinate system. In these cases, spatial direction may serve
as useful count directions:

    [COUNTER_COUNT_DIRECTION_NORTH] = "north",
    [COUNTER_COUNT_DIRECTION_NORTHEAST] = "northeast",
    [COUNTER_COUNT_DIRECTION_EAST] = "east",
    [COUNTER_COUNT_DIRECTION_SOUTHEAST] = "southeast",
    [COUNTER_COUNT_DIRECTION_SOUTH] = "south",
    [COUNTER_COUNT_DIRECTION_SOUTHWEST] = "southwest",
    [COUNTER_COUNT_DIRECTION_WEST] = "west",
    [COUNTER_COUNT_DIRECTION_NORTHWEST] = "northwest"

A const table is conveinent in these scenarios because support for new
count directions may be easily added by simple entry into the table.

William Breathitt Gray
