From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/12] device: property: find
	dependencies of a firmware node
Date: Sat, 11 Jul 2015 04:52:29 +0200
Message-ID: <4693466.kRRNMahPuB@vostro.rjw.lan>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <2589152.el9mWEWqDg@vostro.rjw.lan>
 <CAAObsKC-71GsBWZdNjm5Cxek07=9dwzTp8mYezVXkt_k3mzKVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAAObsKC-71GsBWZdNjm5Cxek07=9dwzTp8mYezVXkt_k3mzKVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Friday, July 10, 2015 03:14:38 PM Tomeu Vizoso wrote:
> On 2 July 2015 at 02:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, July 01, 2015 11:40:57 AM Tomeu Vizoso wrote:
> >> Adds API that allows callers to find out what other firmware nodes a
> >> node depends on.
> >>
> >> Implementors of bindings documentation can register callbacks that
> >> return the dependencies of a node.
> >>
> >> Dependency information can be used to change the order in which devices
> >> are probed, or to print a warning when a device node is going to be
> >> probed without all its dependencies fulfilled.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >
> > I'd like to see a description of the new API in English in the changelog.
> 
> Agreed.
> 
> >> ---
> >>
> >> Changes in v2:
> >> - Allow bindings implementations register a function instead of using
> >>   class callbacks, as not only subsystems implement firmware bindings.
> >>
> >>  drivers/base/property.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/fwnode.h   |  5 +++
> >>  include/linux/property.h | 12 +++++++
> >>  3 files changed, 108 insertions(+)
> >>
> >> diff --git a/drivers/base/property.c b/drivers/base/property.c
> >> index 8ead1ba..9d38ede 100644
> >> --- a/drivers/base/property.c
> >> +++ b/drivers/base/property.c
> >> @@ -19,7 +19,13 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/property.h>
> >>
> >
> > Please add a comment describing this structure.  In particular, what it is
> > supposed to be used for and how it is supposed to be used.
> 
> Ok.
> 
> >> +struct dependency_parser {
> >> +     struct list_head parser;
> >
> > I'd rather call this "list_node" or something like that.
> 
> Ok.
> 
> >> +     void (*func)(struct fwnode_handle *fwnode, struct list_head *deps);
> >> +};
> >> +
> >>  static bool fwnode_match_enable = false;
> >> +static LIST_HEAD(dependency_parsers);
> >>
> >>  /**
> >>   * device_add_property_set - Add a collection of properties to a device object.
> >> @@ -553,6 +559,27 @@ bool device_dma_is_coherent(struct device *dev)
> >>  EXPORT_SYMBOL_GPL(device_dma_is_coherent);
> >>
> >>  /**
> >> + * fwnode_add_dependency - add firmware node to the passed dependency list
> >> + * @fwnode: Firmware node to add to dependency list
> >> + * @list: Dependency list to add the fwnode to
> >> + */
> >> +void fwnode_add_dependency(struct fwnode_handle *fwnode,
> >> +                        struct list_head *list)
> >> +{
> >> +     struct fwnode_dependency *dep;
> >> +
> >> +     dep = kzalloc(sizeof(*dep), GFP_KERNEL);
> >> +     if (!dep)
> >> +             return;
> >> +
> >> +     INIT_LIST_HEAD(&dep->dependency);
> >> +     dep->fwnode = fwnode;
> >> +
> >> +     list_add_tail(&dep->dependency, list);
> >> +}
> >> +EXPORT_SYMBOL_GPL(fwnode_add_dependency);
> >> +
> >> +/**
> >>   * fwnode_get_parent - return the parent node of a device node
> >>   * @fwnode: Device node to find the parent node of
> >>   */
> >> @@ -600,6 +627,70 @@ bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible)
> >>  EXPORT_SYMBOL_GPL(fwnode_is_compatible);
> >>
> >>  /**
> >> + * fwnode_add_dependency_parser - register dependency parser
> >> + * @func: Function that will be called to find out dependencies of a node
> >> + *
> >> + * Registers a callback that will be called when collecting the dependencies
> >> + * of a firmware node. The callback should inspect the properties of the node
> >> + * and call fwnode_add_dependency() for each dependency it recognizes, from
> >> + * the bindings documentation.
> >> + */
> >> +void fwnode_add_dependency_parser(
> >> +     void (*func)(struct fwnode_handle *fwnode, struct list_head *deps))
> >> +{
> >> +     struct dependency_parser *parser;
> >> +
> >> +     parser = kzalloc(sizeof(*parser), GFP_KERNEL);
> >> +     if (!parser)
> >> +             return;
> >> +
> >> +     INIT_LIST_HEAD(&parser->parser);
> >> +     parser->func = func;
> >> +
> >> +     list_add_tail(&parser->parser, &dependency_parsers);
> >
> > We're modifying a global list here.  Any locking needed?  RCU?  Whatever?
> 
> Oops.
> 
> >> +}
> >> +EXPORT_SYMBOL_GPL(fwnode_add_dependency_parser);
> >> +
> >> +/**
> >> + * fwnode_remove_dependency_parser - unregister dependency parser
> >> + * @func: Function that was to be called to find out dependencies of a node
> >> + */
> >> +void fwnode_remove_dependency_parser(
> >> +     void (*func)(struct fwnode_handle *fwnode, struct list_head *deps))
> >> +{
> >> +     struct dependency_parser *parser, *tmp;
> >> +
> >> +     list_for_each_entry_safe(parser, tmp, &dependency_parsers, parser) {
> >> +             if (parser->func == func) {
> >> +                     list_del(&parser->parser);
> >> +                     kfree(parser);
> >> +                     return;
> >> +             }
> >> +     }
> >> +}
> >> +EXPORT_SYMBOL_GPL(fwnode_remove_dependency_parser);
> >> +
> >> +/**
> >> + * fwnode_get_dependencies - find out what dependencies a firmware node has
> >> + * @fwnode: firmware node to find its dependencies
> >> + * @deps: list of struct fwnode_dependency in which dependencies will be placed
> >> + */
> >> +void fwnode_get_dependencies(struct fwnode_handle *fwnode,
> >> +                          struct list_head *deps)
> >> +{
> >> +     struct dependency_parser *parser;
> >> +     struct fwnode_handle *child;
> >> +
> >> +     list_for_each_entry(parser, &dependency_parsers, parser)
> >> +             parser->func(fwnode, deps);
> >> +
> >> +     /* Some device nodes will have dependencies in non-device sub-nodes */
> >> +     fwnode_for_each_child_node(fwnode, child)
> >> +             if (!fwnode_property_present(child, "compatible"))
> >
> > This is a blatant OF-ism.  We need to think about a generic way to express that.
> 
> My impression from reading the existing usage of fwnode in gpiolib and
> the examples in the link below was that we were going to share the
> bindings between DT and ACPI. Doesn't that extend to the meaning of
> the compatible property?
> 
> http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

Not entirely.

An ACPI device object without the "compatible" property may still represent a valid
device (and usually does), so it is not enough to check whether or not the "compatible"
property is present for that in general.

Thanks,
Rafael
